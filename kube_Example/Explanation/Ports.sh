Service: This directs the traffic to a pod.

TargetPort: This is the actual port on which your application is running inside the container.

Port: Sometimes your application inside the container serves different services on a different port.

Example: The actual application can run on port 8080 and health checks for this application can run on port 8089 of the container. So if you hit the service without a port, it doesn't know to which port of the container it should redirect the request. The service needs to have a mapping so that it can hit the specific port of the container.

kind: Service
apiVersion: v1
metadata:
  name: my-service
spec:
  selector:
    app: MyApp
  ports:
    - name: http
      nodePort: 30475
      port: 8089
      protocol: TCP
      targetPort: 8080
    - name: metrics
      nodePort: 31261
      port: 5555
      protocol: TCP
      targetPort: 5555
    - name: health
      nodePort: 30013
      port: 8443
      protocol: TCP
      targetPort: 8085 
if you hit my-service:8089, the traffic is routed to 8080 of the container(targetPort). Similarly, if you hit my-service:8443, then it is redirected to 8085 of the container(targetPort). But this myservice:8089 is internal to the kubernetes cluster and can be used when one application wants to communicate with another application. So, to hit the service from outside the cluster someone needs to expose the port on the host machine on which kubernetes is running so that the traffic is redirected to a port of the container. This is nodePort(port exposed on the host machine). From the above example, you can hit the service from outside the cluster(Postman or any rest-client) by host_ip:nodePort

Say your host machine ip is 10.10.20.20 you can hit the http, metrics, health services by 10.10.20.20:30475, 10.10.20.20:31261, 10.10.20.20:30013.