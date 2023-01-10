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


#### Debugging
```
(gdb) b main
(gdb) r
```