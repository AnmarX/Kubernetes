# to enter a container in a pod directly from kubectl
kubectl exec -it <pod-name> -n <container-name> -- bash

# to enter the pod from the node, listing all the runing containers
crictl ps

# to enter the container from the node
crictl exec -it <container-name> bash