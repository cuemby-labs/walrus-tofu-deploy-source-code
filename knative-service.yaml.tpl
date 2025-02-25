apiVersion: serving.knative.dev/v1
kind: Service
metadata:
  name: ${name}
  namespace: ${namespace}
spec:
  template:
    metadata:
      annotations:  
        autoscaling.knative.dev/minScale: "1"
        autoscaling.knative.dev/maxScale: "5"
    spec:
      containers:
        - image: "${registry_server}/${image}"
          ports:
${container_ports}
          env:
            - name: TARGET
              value: "Knative!"
