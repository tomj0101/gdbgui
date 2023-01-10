# lbtester
Docker images for Test load balancer

#### Local Run (dev)
```
npm install
node app.js
open http://localhost:8888/v3/ui
open http://localhost:8888/v3/app


npm install --save docker-container-id
npm install --save express
npm install --save body-parser
npm install --save cors

Embedded JavaScript templating.
https://ejs.co/
npm install --save ejs

npm install nodemon --save-dev

```



#### Push to your Private or Public containers register (DevOps)
Docker Hub (docker.io)
```
docker build -t tomj0101/lbtester:lasted -f Dockerfile.lbtester .
Create repo on dockerhub > https://hub.docker.com/repository

docker images

docker logout
docker login
docker push tomj0101/lbtester:lasted
```

#### Run Docker (Dev)
```
docker run -p 8888:8888 tomj0101/lbtester:lasted
```


#### Local Deploy in Kubernetes (MiniKube)
```
kubectl apply -f lbtester-deployment.yaml
kubectl delete -f lbtester-deployment.yaml

kubectl apply -f lbtester-service.yaml
kubectl delete -f lbtester-service.yaml

kubectl describe service lbtester-service -n sample-namespace
Name:                     lbtester-service
Namespace:                sample-namespace
Labels:                   app=lbtester
Annotations:              <none>
Selector:                 app=lbtester
Type:                     NodePort
IP Family Policy:         SingleStack
IP Families:              IPv4
IP:                       10.109.94.186
IPs:                      10.109.94.186
Port:                     <unset>  4444/TCP
TargetPort:               8888/TCP
NodePort:                 <unset>  31765/TCP
Endpoints:                172.17.0.10:8888,172.17.0.11:8888,172.17.0.12:8888 + 5 more...
Session Affinity:         None
External Traffic Policy:  Cluster
Events:                   <none>


Take the NodePort
open http://10.109.94.186:4444/v3/ui
open http://10.109.94.186:4444/v3/app


remove image from CACHE in minikube
minikube cache delete tomj0101/lbtester

load images from local to minikube
minikube image load tomj0101/lbtester:lasted
```


### Test the different output for the load balacer.
```
curl http://10.109.94.186:4444/v3/app
{"hostname":"lbtester-deployment-66798999d9-dmkk8"}

curl http://10.109.94.186:4444/v3/app
{"hostname":"lbtester-deployment-66798999d9-cj7hk"}

curl http://10.109.94.186:4444/v3/app
{"hostname":"lbtester-deployment-66798999d9-l4bm8"}

curl http://10.109.94.186:4444/v3/app
{"hostname":"lbtester-deployment-66798999d9-dmkk8"}

curl http://10.109.94.186:4444/v3/app
{"hostname":"lbtester-deployment-66798999d9-dmkk8"}

curl http://10.109.94.186:4444/v3/app
{"hostname":"lbtester-deployment-66798999d9-fxvv8"}

curl http://10.109.94.186:4444/v3/app
{"hostname":"lbtester-deployment-66798999d9-cmzx2"}

curl http://10.109.94.186:4444/v3/app
{"hostname":"lbtester-deployment-66798999d9-cj7hk"}
```