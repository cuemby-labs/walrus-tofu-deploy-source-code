resource "kubernetes_ingress_v1" "ingress" {
  metadata {
    name        = var.app_name
    namespace   = var.app_namespace
    annotations = merge(
      {
        "nginx.ingress.kubernetes.io/server-snippet" = <<-EOT
          location ~ /\.git { 
            deny all; 
            return 404; 
          }
        EOT
      },
      var.annotations
    )
    labels      = local.labels
  }

  wait_for_load_balancer = true

  spec {
    dynamic "default_backend" {
      iterator = backend
      for_each = var.default_backend

      content {
        dynamic "resource" {
          iterator = resource
          for_each = lookup(backend.value, "resource", [])
          content {
            name      = lookup(backend.value, "resource_name", null)
            api_group = lookup(backend.value, "resource_api_group", null)
            kind      = lookup(backend.value, "resource_kind", null)
          }
        }

        dynamic "service" {
          iterator = service
          for_each = lookup(backend.value, "service", [])

          content {
            name = lookup(backend.value, "service_name", null)
            port {
              name   = lookup(backend.value, "service_port_name", null)
              number = lookup(backend.value, "service_port_number", null)
            }
          }
        }
      }
    }

    ingress_class_name = var.ingress_class_name

    dynamic "rule" {
      iterator = rule
      for_each = var.http_rules

      content {
        host = rule.value.host
        http {
          path {
            path      = lookup(rule.value, "path", "/")
            path_type = lookup(rule.value, "path_type", "Prefix")
            backend {
              dynamic "resource" {
                iterator = backend
                for_each = lookup(rule.value, "resource", [])
                content {
                  name      = lookup(resource.value, "name", null)
                  api_group = lookup(resource.value, "api_group", null)
                  kind      = lookup(resource.value, "kind", null)
                }
              }
              dynamic "service" {
                iterator = service
                for_each = lookup(rule.value, "service", [])

                content {
                  name = lookup(service.value, "name", null)
                  port {
                    name   = lookup(service.value, "port_name", null)
                    number = lookup(service.value, "port_number", null)
                  }
                }
              }
            }
          }
        }
      }
    }

    dynamic "tls" {
      iterator = tls
      for_each = var.tls_rules

      content {
        hosts       = lookup(tls.value, "hosts", [])
        secret_name = lookup(tls.value, "secret_name", replace(tls.value.hosts[0], ".", "-"))
      }
    }
  }
}
