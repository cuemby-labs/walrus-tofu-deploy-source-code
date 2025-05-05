terraform {
  required_version = ">= 1.6.0"

  required_providers {
    kaniko = {
      source  = "seal-io/kaniko"
      version = "0.0.3"
    }
    kubernetes = {
      source  = "txomon/kubernetes"
      version = "2.23.0"
    }
    template = {
      source  = "hashicorp/template"
      version = ">= 2.2.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.19.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.3"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.7"
    }
    local = {
      source = "hashicorp/local"
      version = "~> 2.0"
    }
  }
}
