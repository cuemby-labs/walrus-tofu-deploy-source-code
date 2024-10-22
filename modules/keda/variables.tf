variable "name" {
  type        = string
  description = "(Required) Name of the deployment"
}
variable "namespace" {
  type        = string
  description = "(Optional) Namespace in which to create the deployment"
  default     = "default"
}
variable "replicas" {
  type        = number
  description = "(Optional) Count of pods"
  default     = 1
}
variable "limit_cpu" {
  type        = string
  description = "CPU limit. e.g. 0.5, 1, 2"
  default     = ""
}
variable "limit_memory" {
  type        = string
  description = "Memory limit. e.g. 128Mi, 512Mi, 1Gi, 2Gi, 4Gi"
  default     = ""
}