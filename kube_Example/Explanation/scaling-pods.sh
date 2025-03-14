kubectl scale deployment <deployment-name> --replicas=2


if you have a deploy with 2 pods and created a third pod on the same deploy but from cli
if you re-roll the deploy it wont delete the third pod but it will only restart it, but if you 
applied the yml file again (kube apply -f <deploy.yml>) it will bring back the pods into 2 pods only
and delete the third pod