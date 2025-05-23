########
# Build
########

# @label "Git URL"
# @group "Build"
variable "git_url" {
  type        = string
  description = "URL to the source code repository."
}
# @label "Git Branch"
# @group "Build"
variable "git_branch" {
  type        = string
  default     = "main"
  description = "Branch of the repository to clone."
}
# @label "Git Tag"
# @group "Build"
variable "git_tag" {
  type        = string
  default     = ""
  description = "Tag of the repository to clone."
}
# @label "Git Commit"
# @group "Build"
variable "git_commit" {
  description = "Commit hash específico a clonar"
  type        = string
  default     = ""
}
# @label "Git Authentication"
# @group "Build"
variable "git_auth" {
  type        = bool
  default     = false
  description = "Git authentication enabled."
}
# @label "Git Username"
# @group "Build"
# @show_if "git_auth=true"
variable "git_username" {
  type        = string
  default     = null
  sensitive   = true
  description = "Username for cloning the git repository."
}
# @label "Git Password"
# @group "Build"
# @show_if "git_auth=true"
variable "git_password" {
  type        = string
  default     = null
  sensitive   = true
  description = "Password for cloning the git repository."
}
# # @label "Sub Path"
# # @group "Build"
# variable "git_path" {
#   type        = string
#   default     = null
#   description = "Path to the source code."
# }
# @label "Dockerfile Path"
# @group "Build"
variable "dockerfile" {
  type        = string
  default     = "Dockerfile"
  description = "Path to the Dockerfile."
}
# @label "Registry Authentication"
# @group "Build"
variable "registry_auth" {
  type        = bool
  default     = false
  description = "Registry authentication enabled."
}
# @label "Registry Server"
# @group "Build"
# @show_if "registry_auth=true"
variable "registry_server" {
  type        = string
  default     = "docker.io"
  description = "Server for the image registry."
}
# @label "Registry Username"
# @group "Build"
# @show_if "registry_auth=true"
variable "registry_username" {
  type        = string
  default     = null
  sensitive   = true
  description = "Username for the image registry."
}
# @label "Registry Password"
# @group "Build"
# @show_if "registry_auth=true"
variable "registry_password" {
  type        = string
  default     = null
  sensitive   = true
  description = "Password for the image registry."
}
# @label "Image Name"
# @group "Build"
variable "image" {
  type        = string
  description = "Name of the image to be built and deployed."
}

########
# Deploy 
########

# @label "Replicas"
# @group "Deploy/Basic"
variable "replicas" {
  type        = number
  description = "Count of pods"
  default     = 1
}
# @label "Ports"
# @group "Deploy/Basic"
variable "ports" {
  type        = list(number)
  description = "Service ports to expose"
  default     = [80]
}
# @label "Environment Variables"
# @group "Deploy/Basic"
variable "env" {
  type        = map(string)
  description = "Name and value pairs to set as the environment variables"
  default     = {}
}
# @label "Environment Variables"
# @group "Deploy/Basic"
variable "labels" {
  type        = map(string)
  description = "List of labels to set it in knative"
  default     = {}
}
# @group "Deploy/Resources"
# @label "CPU Request"
variable "request_cpu" {
  type        = string
  description = "CPU request. e.g. 0.5, 1, 2"
  default     = "0.1"
}
# @group "Deploy/Resources"
# @label "Memory Request"
variable "request_memory" {
  type        = string
  description = "Memory request. e.g. 128Mi, 512Mi, 1Gi, 2Gi, 4Gi"
  default     = "128Mi"
}
# @group "Deploy/Resources"
# @label "CPU Limit"
variable "limit_cpu" {
  type        = string
  description = "CPU limit. e.g. 0.5, 1, 2"
  default     = ""
}
# @group "Deploy/Resources"
# @label "Memory Limit"
variable "limit_memory" {
  type        = string
  description = "Memory limit. e.g. 128Mi, 512Mi, 1Gi, 2Gi, 4Gi"
  default     = ""
}
# @group "Deploy/Advanced"
# @label "Namespace"
variable "namespace" {
  type        = string
  description = "Namespace to deploy. Auto-generated if empty."
  default     = ""
}
# @group "Deploy/Advanced"
# @label "Deployment Name"
variable "name" {
  type        = string
  description = "Name of the deployment resource. Auto-generated if empty."
  default     = ""
}

###############
# Expose
###############
# @group "Expose/Basic"
# @label "Ingress Enabled"
# variable "ingress_enabled" {
#   type        = bool
#   description = "(Optional) Enabled exposing via ingress."
#   default     = false
# }
# @group "Expose/Basic"
# @label "Ingress Enabled TLS"
# @show_if "ingress_enabled=true"
# variable "ingress_tls_enabled" {
#   type        = bool
#   description = "(Optional) Enabled TLS."
#   default     = false
# }
# @group "Expose/Basic"
# @label "Ingress Host"
# @show_if "ingress_enabled=true"
# variable "ingress_host" {
#   type        = string
#   description = "(Optional) Add ingress host."
#   default     = ""
# }
# @group "Expose/Advanced"
# @label "Ingress Annotations"
# @show_if "ingress_enabled=true"
# variable "ingress_annotations" {
#   type        = map(string)
#   description = "(Optional) Add annotations"
#   default     = {}
# }
# @group "Expose/Advanced"
# @label "Ingress Class Name"
# @show_if "ingress_enabled=true"
# variable "ingress_class_name" {
#   type        = string
#   description = "(Optional) Add an ingress class name."
#   default     = "nginx"
# }


###############
# Walrus metadata
###############

# @hidden
variable "walrus_metadata_service_name" {
  type        = string
  description = "Walrus metadata service name."
  default     = ""
}
# @hidden
variable "walrus_metadata_namespace_name" {
  type        = string
  description = "Walrus metadata namespace name."
  default     = ""
}

#
# Contextual Fields
#

variable "context" {
  description = <<-EOF
Receive contextual information. When Walrus deploys, Walrus will inject specific contextual information into this field.

Examples:
```
context:
  project:
    name: string
    id: string
  environment:
    name: string
    id: string
  resource:
    name: string
    id: string
```
EOF
  type        = map(any)
  default     = {}
}