terraform {
  required_version = ">= 1.6.0"

  required_providers {
    kaniko = {
      source  = "seal-io/kaniko"
      version = "0.0.3"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.32.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.3"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.7"
    }
  }
}
