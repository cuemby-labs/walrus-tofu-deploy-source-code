terraform {
  required_version = "v1.6.2"
}

module "service_jenkins" {
  source           = "../.."
  app_name         = "jenkins2"
  app_namespace    = "jenkins2"
  port_mapping     = var.port_mapping
  type             = "LoadBalancer"
  load_balancer_ip = "134.13.13.24" // Also you can get from google_compute_address.static_external_ip.address
  load_balancer_ips_whitelist = [
    "10.10.10.0/24",
    "34.23.145.91/32"
  ]
}

variable "port_mapping" {
  type = list(object({
    name          = string
    internal_port = string
    external_port = string
    protocol      = optional(string)
  }))
  default = [
    {
      name          = "web-access" // (Required) Port name
      internal_port = "8080"       // (Required) Pod port
      external_port = "80"         // (Required) Port for others container's
      node_port     = "30000"      // (Optional) set Node Port. By default K8S automatically set free Node Port
    },
    {
      name          = "service-port" // (Required) Port name
      internal_port = "3000"         // (Required) Pod port
      external_port = "90"           // (Required) Port for others container's
      portocol      = "UDP"          // (Optional) The IP protocol for this port. Supports TCP and UDP. Default is TCP.
    }
  ]
}
