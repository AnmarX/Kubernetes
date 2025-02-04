# add label to make ingress work with the nodes

kubectl label node <node name> ingress-ready=true  


# download the file from the repo of the ngninx controller

curl -LO https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml

#or

#you can apply it directly
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml

# apply the manifist

kubectl apply -f deploy.yaml

# check the ingress controller pod; -n = namespace

kubectl get pods -n ingress-nginx

# check the service

kubectl get svc -n ingress-nginx


#deploey the ingress yml file; -f = that mean its a file

kubectl apply -f <ingress yml file>

# For Local Testing:

# Since KIND runs inside Docker, you might need to use port-forwarding to access the ingress controller # externally. For example:

#svc = service
kubectl port-forward svc/ingress-nginx-controller -n ingress-nginx 8080:80
