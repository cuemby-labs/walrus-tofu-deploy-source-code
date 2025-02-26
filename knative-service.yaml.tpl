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
    spec:
      containers:
        - image: "${registry_server}/${image}"
          ports:
${container_ports}
          env:
            - name: TARGET
              value: "Knative!"
          resources:
            requests:
              cpu: ${request_cpu}
              memory: ${request_memory}
            limits:
              cpu: ${limit_cpu}
              memory: ${limit_memory}
