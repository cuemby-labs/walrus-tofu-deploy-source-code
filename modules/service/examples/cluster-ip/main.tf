terraform {
  required_version = "v1.6.0"
}

module "service_jenkins" {
  source        = "../.."
  app_name      = "jenkins1"
  app_namespace = "jenkins1"
  port_mapping  = var.port_mapping
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
    },
    {
      name          = "service-port" // (Required) Port name
      internal_port = "3000"         //(Required) Pod port
      external_port = "90"           //(Required) Port for others container's
      portocol      = "UDP"          // (Optional) The IP protocol for this port. Supports TCP and UDP. Default is TCP.
    }
  ]
}
