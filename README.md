# gdbgui-docker
Docker image for gdbgui.com
<img height="750px" src="docs/gdbgui-ui.png">

#### Build 
```
$ docker build -t tomj0101/gdbgui:lasted .

$ docker images
REPOSITORY                    TAG       IMAGE ID       CREATED         SIZE
tomj0101/gdbgui               lasted    725a31967a36   2 minutes ago   95.7MB

```

#### Local Run (Dev)
```
$ docker pull tomj0101/gdbgui:lasted
$ docker run -p 5555:5555 tomj0101/gdbgui:lasted

$ open http://localhost:5555/

Load Binary> /app/samplev1
Load Binary> /app/samplev2

```


#### Debugging (Dev)
```
(gdb) b main
(gdb) r
(gdb) n
```

#### Push to your Private or Public containers register (DevOps)
Docker Hub (docker.io)
```
export DOCKER_USER_ID="tomj0101"
Create repo on dockerhub > https://hub.docker.com/repository
docker tag tomj0101/gdbgui:lasted $DOCKER_USER_ID/gdbgui:lasted
docker tag tomj0101/gdbgui:lasted tomj0101/gdbgui:lasted

docker logout
docker login
docker push tomj0101/gdbgui:lasted
```

#### Local k8s deploy in Minikube (DevOps)
```
$ minikube start
$ minikube dashboard
# minikube tunnel


$ kubectl apply -f sample-namespace.yaml
$ kubectl get namespaces --show-labels

$ kubectl apply -f gdbgui-deployment.yaml
$ kubectl get deployments -n sample-namespace --show-labels
$ kubectl delete -f gdbgui-deployment.yaml
```


#### Setup ingress in Minikube & expose application to internet
````
$ kubectl apply -f gdbgui-service.yaml
$ kubectl delete -f gdbgui-service.yaml

$ kubectl get service gdbgui-service -n sample-namespace
$ kubectl describe service gdbgui-service -n sample-namespace
Name:                     gdbgui-service
Namespace:                sample-namespace
Labels:                   app=gdbgui
Annotations:              <none>
Selector:                 app=gdbgui
Type:                     NodePort
IP Family Policy:         SingleStack
IP Families:              IPv4
IP:                       10.96.231.13
IPs:                      10.96.231.13
Port:                     <unset>  8888/TCP
TargetPort:               5555/TCP
NodePort:                 <unset>  31535/TCP
Endpoints:                172.17.0.9:5555
Session Affinity:         None
External Traffic Policy:  Cluster
Events:                   <none>



Take the NodePort
open http://10.96.231.13:8888/


---- Manual ----

$ kubectl expose deployment gdbgui-deployment --name=gdbgui-service --type=NodePort --port=8888 -n sample-namespace
$ kubectl delete service gdbgui-service -n sample-namespace


get the service yaml from the command
$ kubectl get service gdbgui-services -o yaml -n sample-namespace


````

#### Setup ingress in Minikube & expose application to internet
````
# minikube tunnel
$ minikube ip
$ kubectl get svc -A
$ minikube addons disable ingress
$ minikube addons enable ingress
$ kubectl get pods -n ingress-nginx
```




#### network tools
````
$ kubectl create -f ntools-deployment.yaml
$ kubectl get deployments -n sample-namespace --show-labels

$ kubectl delete -f ntools-deployment.yaml

get the pods internal IP inside the cluster.
$ kubectl get pods -n sample-namespace -o wide
NAME                                 READY   STATUS    RESTARTS   AGE     IP           NODE       NOMINATED NODE   READINESS GATES
gdbgui-deployment-66b4547db4-zx8jh   1/1     Running   0          27m     172.17.0.5   minikube   <none>           <none>
ntools-deployment-57b696dfb6-zzmmn   1/1     Running   0          4m12s   172.17.0.6   minikube   <none>           <none>

$ kubectl get pod -n sample-namespace ntools-deployment-57b696dfb6-zzmmn
$ kubectl describe pod -n sample-namespace ntools-deployment-57b696dfb6-zzmmn

exec remote command
$ kubectl exec -it -n sample-namespace ntools-deployment-57b696dfb6-zzmmn -- /bin/bash  -c "ip addr show"

login into the pod
$ kubectl exec -it -n sample-namespace ntools-deployment-57b696dfb6-zzmmn -- /bin/bash


(pod ntool) $ ip addr show
(pod ntool) $ ping 172.17.0.5
(pod ntool) $ curl 172.17.0.5:5555
````
