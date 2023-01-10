# gdbgui-docker
Docker image for gdbgui.com

#### Build 
```
$ docker build -t tomj0101/gdbgui:lasted .

$ docker images
REPOSITORY                    TAG       IMAGE ID       CREATED         SIZE
tomj0101/gdbgui               lasted    725a31967a36   2 minutes ago   95.7MB

```

#### Local Run (Dev)
```
$ docker run -p 5555:5555 tomj0101/gdbgui:lasted

$ open http://localhost:5555/

Load Binary> /app/samplev1
Load Binary> /app/samplev2

```


#### Debugging (Dev)
```
(gdb) b main
(gdb) r
```

#### Push to your Private or Public containers register (DevOps)
Docker Hub (docker.io)
```
export DOCKER_USER_ID="john"
# Create repo on dockerhub
docker tag tomj0101/gdbgui:lasted $DOCKER_USER_ID/gdbgui:lasted

docker login
docker push $DOCKER_USER_ID/gdbgui:lasted
```

#### Local k8s deploy in Minikube (DevOps)
```
$ minikube start
$ minikube dashboard


$ kubectl create -f sample-namespace.yaml
$ kubectl get namespaces --show-labels

$ kubectl create -f gdbgui-deployment.yaml
$ kubectl get deployments -n sample-namespace --show-labels
$ kubectl delete -f gdbgui-deployment.yaml

$ kubectl create -f gdbgui-service.yaml
$ kubectl get services

```


#### Setup ingress in Minikube & expose application to internet
````
# minikube tunnel
$ minikube ip
$ kubectl get svc -A

$ minikube addons enable ingress
$ kubectl get pods -n ingress-nginx
$ kubectl expose deployment gdbgui-deployment --name=gdbgui-svc --type=NodePort --port=5555 -n sample-namespace
$ kubectl describe service gdbgui-svc -n sample-namespace
$ kubectl describe service gdbgui-svc -n sample-namespace
Name:                     gdbgui-svc
Namespace:                sample-namespace
Labels:                   app=gdbgui
Annotations:              <none>
Selector:                 app=gdbgui
Type:                     NodePort
IP Family Policy:         SingleStack
IP Families:              IPv4
IP:                       10.110.223.66
IPs:                      10.110.223.66
Port:                     <unset>  5555/TCP
TargetPort:               5555/TCP
NodePort:                 <unset>  31442/TCP
Endpoints:                172.17.0.5:5555
Session Affinity:         None
External Traffic Policy:  Cluster
Events:                   <none>


Take the NodePort
open http://10.110.223.66:5555/

````




#### network tools
````
$ kubectl create -f ntools-deployment.yaml
$ kubectl get deployments -n sample-namespace --show-labels
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