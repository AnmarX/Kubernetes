# first you need to deterimane who controlle the pod by using the command 
kubectl describe pod web-application-688699f5fb-56cqj

# if you see Controlled By:  ReplicaSet/web-application-688699f5fb
# that means its been controlled by deployment
# checking by using this command
# you will see something like this Controlled By:  Deployment/web-application
kubectl describe replicaset web-application-688699f5fb



# if its not showing the controlled by that means its created manully like this
kubectl run nginx --image=nginx

