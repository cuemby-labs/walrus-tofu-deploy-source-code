#######
# Build
#######

resource "kaniko_image" "image" {
  # Only handle git context. Explicitly use the git scheme.
  context     = "${local.formal_git_url}#refs/heads/${var.git_branch}"
  dockerfile  = var.dockerfile
  destination = "${var.registry_server}/${var.image}"

  git_username      = var.git_auth ? var.git_username : ""
  git_password      = var.git_auth ? var.git_password : ""
  registry_username = var.registry_auth ? var.registry_username : ""
  registry_password = var.registry_auth ? var.registry_password : ""

  always_run = true
}

module "image_pull_secrets" {
  count = var.registry_auth ? 1 : 0

  depends_on = [resource.kaniko_image.image]

  source    = "./modules/image-pull-secret"
  name      = local.name
  namespace = local.namespace
  server    = var.registry_server
  username  = var.registry_username
  password  = var.registry_password
}

########
# Deploy 
########

module "deployment" {
  depends_on = [resource.kaniko_image.image]

  # disable wait for all pods be ready.
  #
  wait_for_rollout = false

  # Use local paths to avoid accessing external networks
  # This module comes from terraform registry "terraform-iaac/deployment/kubernetes 1.4.2"
  source = "./modules/deployment"

  name      = local.name
  namespace = local.namespace
  image     = "${var.registry_server}/${var.image}"
  image_pull_secrets = var.registry_auth ? {
    (local.name) : data.kubernetes_secret.image_pull_secrets.metadata[0].name
  } : {}
  replicas = var.replicas
  resources = {
    request_cpu    = var.request_cpu == "" ? null : var.request_cpu
    limit_cpu      = var.limit_cpu == "" ? null : var.limit_cpu
    request_memory = var.request_memory == "" ? null : var.request_memory
    limit_memory   = var.limit_memory == "" ? null : var.limit_memory
  }
  env = var.env
  template_annotations = []
  deployment_annotations = var.deployment_annotations
}

module "service" {
  depends_on = [resource.kaniko_image.image]

  # Use local paths to avoid accessing external networks
  # This module comes from terraform registry "terraform-iaac/service/kubernetes 1.0.4"
  source = "./modules/service"

  app_name      = local.name
  app_namespace = local.namespace
  type          = "NodePort"
  port_mapping = [for p in var.ports :
    {
      name          = "port-${p}"
      internal_port = p
      external_port = p
      protocol      = "TCP"
  }]
}

module "ingress" {
  count = var.ingress_enabled ? 1 : 0

  depends_on         = [module.deployment, module.service]
  source             = "./modules/ingress"
  app_name           = local.name
  app_namespace      = local.namespace
  annotations        = var.ingress_annotations
  ingress_class_name = var.ingress_class_name
  http_rules = [{
    host     = var.ingress_host
    resource = []
    service = [{
      name        = data.kubernetes_service.service.metadata[0].name
      port_number = data.kubernetes_service.service.spec[0].port[0].port
      # port_name   = data.kubernetes_service.service.spec[0].port[0].name
    }]
  }]
  tls_rules = var.ingress_tls_enabled ? [{
    hosts       = [var.ingress_host]
    secret_name = replace(var.ingress_host, ".", "-")
  }] : []
}

data "kubernetes_secret" "image_pull_secrets" {
  depends_on = [module.image_pull_secrets]

  metadata {
    name      = local.name
    namespace = local.namespace
  }
}

data "kubernetes_service" "service" {
  depends_on = [module.service]

  metadata {
    name      = local.name
    namespace = local.namespace
  }
}

data "kubernetes_ingress_v1" "ingress" {
  depends_on = [module.ingress]

  metadata {
    name      = local.name
    namespace = local.namespace
  }
}

locals {
  context        = var.context
  name           = coalesce(try(var.name, null), try(var.walrus_metadata_service_name, null), try(var.context["resource"]["name"], null))
  namespace      = coalesce(try(var.namespace, null), try(var.walrus_metadata_namespace_name, null), try(var.context["environment"]["namespace"], null))
  formal_git_url = replace(var.git_url, "https://", "git://")
}