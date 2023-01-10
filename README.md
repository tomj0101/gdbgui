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

```