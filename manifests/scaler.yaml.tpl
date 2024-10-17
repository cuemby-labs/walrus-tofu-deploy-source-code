apiVersion: keda.sh/v1alpha1
kind: ScaledObject
metadata:
  name: ${name}
  namespace: ${namespace}
  labels:
    app: ${name}
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment 
    name: ${name}
  minReplicaCount: 1
  maxReplicaCount: ${replicas}
  cooldownPeriod: 300
  pollingInterval: 30
  triggers:
    - type: cpu
      metadata:
        type: "AverageValue" 
        value: ${limit_cpu} 
    - type: memory
      metadata:
        type: "AverageValue" 
        value: ${limit_memory}