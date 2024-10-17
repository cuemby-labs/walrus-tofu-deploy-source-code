apiVersion: keda.sh/v1alpha1
kind: ScaledObject
metadata:
  name: ${walrus_resource_name}
  namespace: ${namespace}
  labels:
    app: ${walrus_resource_name}
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment 
    name: ${walrus_resource_name}
  minReplicaCount: 1
  maxReplicaCount: ${replicas}
  cooldownPeriod: 300
  pollingInterval: 30
  triggers:
    - type: cpu
      metadata:
        type: "AverageValue" 
        value: ${request_cpu} 
    - type: memory
      metadata:
        type: "AverageValue" 
        value: ${request_memory}