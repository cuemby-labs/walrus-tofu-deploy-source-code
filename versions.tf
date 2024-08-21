terraform {
  required_version = ">= 1.5.7"

  required_providers {

    kaniko = {
      source  = "seal-io/kaniko"
      version = "0.0.3"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.30.0"
    }
  }
}
