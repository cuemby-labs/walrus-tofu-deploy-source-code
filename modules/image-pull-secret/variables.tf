variable "name" {
  type        = string
  description = "(Required) Name of the image pull secret"
}
variable "namespace" {
  type        = string
  description = "(Optional) Namespace in which to create the image pull secret"
  default     = "default"
}
variable "annotations" {
  description = "Annotations for image pull secret"
  type        = map(string)
  default     = null
}
variable "custom_labels" {
  description = "(Optional) Add custom label to image pull secret"
  default     = null
  type        = map(string)
}
variable "server" {
  description = "(Optional) Add server registry to image pull secret"
  default     = null
  type        = string
}
variable "username" {
  description = "(Optional) Add username registry to image pull secret"
  default     = null
  type        = string
}
variable "password" {
  description = "(Optional) Add password registry to image pull secret"
  default     = null
  type        = string
}
variable "email" {
  description = "(Optional) Add email registry to image pull secret"
  default     = null
  type        = string
}
