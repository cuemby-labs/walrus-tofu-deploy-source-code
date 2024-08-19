resource "kubernetes_ingress_v1" "ingress" {
  metadata {
    name        = var.app_name
    namespace   = var.app_namespace
    annotations = var.annotations
    labels      = local.labels
  }

  wait_for_load_balancer = true

  spec {
    dynamic "default_backend" {
      iterator = backend
      for_each = var.default_backend

      content {
        resource {
          name      = lookup(backend.value, "resource_name", null)
          api_group = lookup(backend.value, "resource_api_group", null)
          kind      = lookup(backend.value, "resource_kind", null)
        }

        service {
          name = lookup(backend.value, "service_name", null)
          port {
            name   = lookup(backend.value, "service_port_name", null)
            number = lookup(backend.value, "service_port_number", null)
          }
        }
      }
    }

    ingress_class_name = var.ingress_class_name

    dynamic "rule" {
      iterator = rule
      for_each = var.http_rules

      content {
        host = rule.vale.host
        http {
          path {
            path      = lookup(rule.value, "path", "/")
            path_type = lookup(rule.value, "path_type", "Prefix")
            backend {
              resource {
                name      = lookup(rule.value, "resource_name", null)
                api_group = lookup(rule.value, "resource_api_group", null)
                kind      = lookup(rule.value, "resource_kind", null)
              }
              service {
                name = lookup(rule.value, "service_name", null)
                port {
                  name   = lookup(rule.value, "service_port_name", null)
                  number = lookup(rule.value, "service_port_number", null)
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
