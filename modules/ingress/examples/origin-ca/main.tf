terraform {
  required_version = "v1.6.2"
}

module "ingress_origin_ca" {
  source        = "../.."
  app_name      = var.app_name
  app_namespace = var.app_namespace
  annotations = {
    "cert-manager.io/issuer"                              = "origin-ca-issuer"
    "cert-manager.io/issuer-group"                        = "cert-manager.k8s.cloudflare.com"
    "cert-manager.io/issuer-kind"                         = "ClusterOriginIssuer"
    "external-dns.alpha.kubernetes.io/cloudflare-proxied" = true
    "external-dns.alpha.kubernetes.io/hostname"           = "${var.app_name}.example.local"
    "nginx.ingress.kubernetes.io/backend-protocol"        = "HTTP"
    "nginx.ingress.kubernetes.io/force-ssl-redirect"      = true
  }
  http_rules = [{
    host                = "${var.app_name}.example.local"
    service_name        = var.app_name
    service_port_name   = "http"
    service_port_number = 8080
  }]
  tls_rules = [{
    hosts = ["${var.app_name}.example.local"]
  }]
}

variable "app_name" {
  type    = string
  default = "jenkins"
}

variable "app_namespace" {
  type    = string
  default = "jenkins-ci"
}
