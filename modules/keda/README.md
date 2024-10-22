# Keda

This module should run as part of a deployment to ensure a scaledobject has been created.

## Version

* Terraform version 1.0.0
* Kubernetes provider - enable experimental manifest

## Provider section

```hcl
provider "kubernetes" {
  experiments {manifest_resource = true}
}
```

## Supports

* scaledObject for a deployment
  > **Job is not supported at this time**

## Examples (Final YAML version)

A scaled object based on CPU and Memory utilization

```yaml
apiVersion: keda.sh/v1alpha1
kind: ScaledObject
metadata:
  name: router
  namespace: default
  labels:
    name: router-scaledobject
spec:
  scaleTargetRef:
    kind: Deployment
    name: router
  pollingInterval: 30
  cooldownPeriod: 300
  minReplicaCount: 2
  maxReplicaCount: 8
  triggers:
  - type: memory
    metadata:
      type: AverageValue
      value: 200
  - type: cpu
    metadata:
      type: AverageValue
      value: 2
```