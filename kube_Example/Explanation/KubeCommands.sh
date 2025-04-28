#See all resources in a namespace
kubectl get all -n ingress-nginx


#When you use -A, you're telling kubectl to run the command across all namespaces, not just the current or default one.
kubectl get pods -A

# to get nodes label 
kubectl get node <node-name> --show-labels

#add a label to a node
kubectl label node <node-name> <key>=<value>
kubectl label node kind-control-plane ingress-ready=true
