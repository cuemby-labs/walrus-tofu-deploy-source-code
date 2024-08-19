terraform {
  required_version = "v1.6.2"
}

module "service_jenkins" {
  source        = "../.."
  app_name      = "jenkins3"
  app_namespace = "jenkins3"
  port_mapping  = var.port_mapping
  type          = "NodePort"
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
