variable "app_name" {
  type        = string
  description = "(Required) Application name for attach to service"
}
variable "app_namespace" {
  type        = string
  description = "(Required) Namespace where located application"
}
variable "annotations" {
  type        = map(string)
  description = "(Optional) Add annotations"
  default     = {}
}
locals {
  labels = var.custom_labels == null ? { app = var.app_name } : var.custom_labels
}
variable "custom_labels" {
  type        = map(string)
  description = "(Optional) Custom labels & selector"
  default     = null
}
variable "default_backend" {
  type = list(object({
    resource = list(object({
      name      = optional(string)
      api_group = optional(string)
      kind      = optional(string)
    }))
    service = list(object({
      name        = optional(string)
      port_name   = optional(string)
      port_number = optional(number)
    }))
  }))
  default = []
}
variable "ingress_class_name" {
  type    = string
  default = null
}
variable "http_rules" {
  type = list(object({
    host      = string
    path      = optional(string)
    path_type = optional(string)
    resource = optional(list(object({
      name      = string
      api_group = string
      kind      = string
    })))
    service = optional(list(object({
      name        = string
      port_name   = optional(string)
      port_number = optional(number)
    })))
  }))
  default = []
}

variable "tls_rules" {
  type = list(object({
    hosts       = list(string)
    secret_name = optional(string)
  }))
  default = []
}