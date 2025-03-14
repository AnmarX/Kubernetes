# apply the update to pull the new image from docker hub
kubectl apply -f deployment.yaml

#This forces Kubernetes to terminate old Pods and create new ones with the latest image.
kubectl rollout restart deployment web-application

# quicky if you want to see the rollout process
kubectl rollout status deploy web-application



# If you're using the same image tag (e.g., latest), Kubernetes won't detect changes automatically. E.g anmar000/fastapi-app:v2
kubectl set image deployment <deploy-name> <deploy-name>=myrepo/<image-name>:<tag>

#E.g
kubectl set image deployment my-app my-app=anmar000/fastapi-app:v2s




