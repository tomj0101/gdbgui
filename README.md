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

#### Expose port in Minikube

```
# minikube tunnel
$ minikube ip

$ kubectl expose deployment --type=LoadBalancer --port=8080

kubectl expose deployment/gdbgui-deployment --port=80 --type=LoadBalancer

open http://localhost:5555/

```


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