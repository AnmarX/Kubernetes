kubectl patch svc ingress-nginx-controller -n ingress-nginx -p '{"spec": {"type": "ClusterIP"}}'



kubectl patch svc ingress-nginx-controller -n ingress-nginx -p '{"spec": {"type": "LoadBalancer"}}'
