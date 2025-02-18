# add a label to a node
kubectl label node <node-name> <label-key>=<label-value>

# verify the label
kubectl get nodes --show-labels
