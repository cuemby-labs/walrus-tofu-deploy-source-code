apiVersion: serving.knative.dev/v1
kind: Service
metadata:
  name: ${name}
  namespace: ${namespace}
spec:
  template:
    metadata:
      annotations:  
        autoscaling.knative.dev/minScale: "${replicas}"
        autoscaling.knative.dev/maxScale: "5"
      labels:
        cp_platform.project_id: ${project_id}
        cp_platform.environment_id: ${environment_id}
        cp_platform.runtime_id: ${runtime_id}
    spec:
      containers:
        - image: "${registry_server}/${image}"
          ports:
${container_ports}
          env:
${env_vars}
          resources:
            requests:
              cpu: ${request_cpu}
              memory: ${request_memory}
            limits:
              cpu: ${limit_cpu}
              memory: ${limit_memory}
      imagePullSecrets:
        - name: ${image_pull_secrets}
