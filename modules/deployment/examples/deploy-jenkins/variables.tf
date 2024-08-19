variable "app_name" {
  type    = string
  default = "jenkins"
}

variable "app_namespace" {
  type    = string
  default = "jenkins-ci"
}

variable "image" {
  type    = string
  default = "jenkins/jenkins:latest"
}

variable "ports" {
  type = list(object({
    name          = string
    internal_port = string
  }))
  default = [
    {
      name          = "web-access"
      internal_port = "8080"
    }
  ]
}

variable "volume_data" {
  type    = string
  default = "data"
}

variable "volume_logs" {
  type    = string
  default = "logs-from-node"
}

variable "volume_tmp" {
  type    = string
  default = "tmp-from-node"
}

variable "volume_config" {
  type    = string
  default = "jenkins-configmap"
}