# download metalib using helm
helm repo add metallb https://metallb.github.io/metallb
helm install metallb metallb/metallb

# download metalib with default namespace, use this of the above dont work
# it will not work if you put config hostport on the kind config file port 80 and 443
curl -sL https://raw.githubusercontent.com/metallb/metallb/v0.14.9/config/manifests/metallb-native.yaml \
  | sed 's/namespace: metallb-system/namespace: default/g' \
  | kubectl apply -f -

# using kind download ingress nginx 
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.12.1/deploy/static/provider/kind/deploy.yaml

https://raw.githubusercontent.com/kubernetes/ingress-nginx/refs/heads/main/deploy/static/provider/kind/deploy.yaml

kubectl apply -f addresspool.yml

# delete error when applying ingress yml file 
kubectl delete validatingwebhookconfiguration ingress-nginx-admission

#patch svc to be loadbalance 
kubectl patch svc ingress-nginx-controller -n ingress-nginx -p '{"spec": {"type": "LoadBalancer"}}'


#if nginx controller is getting pending after patching use this and delete hostport 80 and 443
kubectl edit deployment ingress-nginx-controller -n ingress-nginx


kubectl label node <your-node-name> ingress-ready=true --overwrite
