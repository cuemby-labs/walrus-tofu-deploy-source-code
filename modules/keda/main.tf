resource "kubernetes_manifest" "scaled_deployment" {
  manifest = {
    "apiVersion" = "keda.sh/v1alpha1"
    "kind"       = "ScaledObject"

    "metadata" = {
        "name"      = var.name
        "namespace" = var.namespace

        "labels" = {
            "name" = var.name
        }
    }

    "spec" = {
        "cooldownPeriod"  = 300
        "maxReplicaCount" = var.replicas # Maximum number of replicas KEDA will scale the resource up to
        "minReplicaCount" = 1            # Minimum number of replicas KEDA will scale the resource down to
        "pollingInterval" = 30

        "scaleTargetRef" = {
            "apiVersion" = "apps/v1"
            "kind"       = "Deployment"
            "name"       = var.name
        }

        "triggers" = [
            {
            type      = "cpu"
                metadata  = {
                    type  = "Utilization"
                    value = 80
                },
            },
            {
            type      = "memory"
                metadata  = {
                    type  = "Utilization"
                    value = 80
                },
            }
    ]
    }
  }
}