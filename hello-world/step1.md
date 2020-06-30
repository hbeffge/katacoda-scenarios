`watch kubectl get pods -A`{{execute HOST1}}

`kubeadm join --discovery-token-unsafe-skip-ca-verification --token=96771a.f608976060d16396 [[HOST_IP]]:6443`{{execute HOST2}}

`watch kubectl get nodes`{{execute HOST1}}

```
sed -i s/HOSTIP/[[HOST_IP]]/g /root/katacoda-cloud-provider.yaml
kubectl apply -f /root/katacoda-cloud-provider.yaml
```{{execute HOST1}}

`kubectl apply -f cloudprov.yaml`{{execute}}

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

https://[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].[[KATACODA_DOMAIN]]
