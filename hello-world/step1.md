`kubectl patch deployment -n kube-system katacoda-cloud-provider --type json --patch '[	{		"op" : "replace" ,		"path" : "/spec/template/spec/containers/0/env/2/value" ,		"value" : "[[HOST_IP]]"	}]'`{{execute}}

`kubectl apply -f cloudprov.yaml`{{execute}}

`export MY_IP=[[HOST_IP]]`{{execute}}

```
kubectl apply -f - <<EOF
apiVersion: v1
kind: Service
metadata:
  name: webapp1-loadbalancer-svc
  labels:
    app: webapp1-loadbalancer
spec:
  type: LoadBalancer
  ports:
  - port: 80
  selector:
    app: webapp1-loadbalancer
  externalIPs:
  - [[HOST_IP]]
  - [[HOST2_IP]]
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: webapp1-loadbalancer-deployment
spec:
  selector:
    matchLabels:
      app: webapp1-loadbalancer
  replicas: 2
  template:
    metadata:
      labels:
        app: webapp1-loadbalancer
    spec:
      containers:
      - name: webapp1-loadbalancer-pod
        image: katacoda/docker-http-server:latest
        ports:
        - containerPort: 80
EOF
```{{execute}}
</pre>
Render port: https://[[HOST_SUBDOMAIN]]-443-[[KATACODA_HOST]].environments.katacoda.com/
