#######
# Build
#######

resource "null_resource" "checkout_commit" {
  count = var.git_commit != "" ? 1 : 0

  provisioner "local-exec" {
    command = <<EOT
    rm -rf repo
    git clone --depth=100 --branch=${var.git_branch} ${var.git_url} repo
    cd repo
    git checkout ${var.git_commit}
    EOT
  }
}

resource "kaniko_image" "image" {
  # Context: use tag if provided, otherwise use branch
  # context = "${local.formal_git_url}#${var.git_commit != "" ? var.git_commit : (var.git_tag != "" ? "refs/tags/${var.git_tag}" : "refs/heads/${var.git_branch}")}"
  # context=git://<git-repo-url>/<git-repo-path>#refs/heads/<branch name>#<commit-id>
  # context="${local.formal_git_url}#refs/heads/${var.git_branch}#${var.git_commit}"
  context     = var.git_commit != "" ? "repo" : "${local.formal_git_url}#${var.git_tag != "" ? "refs/tags/${var.git_tag}" : "refs/heads/${var.git_branch}"}"

  depends_on = [null_resource.checkout_commit]
  # dockerfile  = var.dockerfile
  dockerfile = var.git_commit != "" ? "repo/${replace(var.dockerfile, "./", "")}" : var.dockerfile
  destination = "${var.registry_server}/${var.image}"

  git_username      = var.git_auth ? var.git_username : ""
  git_password      = var.git_auth ? var.git_password : ""
  registry_username = var.registry_auth ? var.registry_username : ""
  registry_password = var.registry_auth ? var.registry_password : ""

  always_run = true
}

# Add delay to wait for the image to be uploaded into the registry

resource "time_sleep" "delay" {
  create_duration = "300s"
}

module "image_pull_secrets" {
  count = var.registry_auth ? 1 : 0

  depends_on = [resource.time_sleep.delay]

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
  depends_on = [resource.time_sleep.delay]

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
}

module "service" {
  depends_on = [resource.time_sleep.delay]

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

# resource "null_resource" "wait_for_url" {
#   provisioner "local-exec" {
#     command = <<EOT

#     status=$(curl -i  https://${var.ingress_host} | grep "HTTP")
#       if [ "$status" = "" ]; then
#         echo "Waiting for URL to become active and SSL certificate to be valid..."
#         sleep 10
#       else
#         echo "URL is active and SSL certificate is valid, proceeding with execution."
#         break
#       fi
#     done

    
#     EOT
#   }
# }


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

#######
# HPA
#######

module "keda_scaleobject" {
  depends_on         = [module.deployment, module.service]

  # Use local paths to avoid accessing external networks
  # This module comes from terraform registry "terraform-iaac/deployment/kubernetes 1.0.0"
  source = "./modules/keda"

  name         = local.name
  namespace    = local.namespace
  replicas     = var.replicas
  limit_cpu    = var.limit_cpu == "" ? null : var.limit_cpu
  limit_memory = var.limit_memory == "" ? null : var.limit_memory
}