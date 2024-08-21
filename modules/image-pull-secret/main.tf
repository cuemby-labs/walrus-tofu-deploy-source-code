resource "kubernetes_secret" "name" {
  metadata {
    name        = var.name
    namespace   = var.namespace
    labels      = local.labels
    annotations = var.annotations
  }

  type = "kubernetes.io/dockerconfigjson"

  data = {
    ".dockerconfigjson" = jsonencode({
      auths = {
        (var.server) = {
          "username" = var.username
          "password" = var.password
          "email"    = var.email
          "auth"     = base64encode("${var.username}:${var.password}")
        }
      }
    })
  }
}