## Kubernetes and docker certifications info 

<img src="cert.png">

### k8s arch 

<img src="arch.png">

## kubeconfig file in client side 

<img src="mergeconf.png">

## setting up config 

<img src="kubeconfig.png">

### history 

```
❯ kubectl  get   nodes
NAME          STATUS   ROLES                  AGE   VERSION
master-node   Ready    control-plane,master   17h   v1.21.1
minion1       Ready    <none>                 17h   v1.21.1
minion2       Ready    <none>                 17h   v1.21.1
❯ kubectl  version
Client Version: version.Info{Major:"1", Minor:"21", GitVersion:"v1.21.1", GitCommit:"5e58841cce77d4bc13713ad2b91fa0d961e69192", GitTreeState:"clean", BuildDate:"2021-05-12T14:18:45Z", GoVersion:"go1.16.4", Compiler:"gc", Platform:"darwin/amd64"}
Server Version: version.Info{Major:"1", Minor:"21", GitVersion:"v1.21.1", GitCommit:"5e58841cce77d4bc13713ad2b91fa0d961e69192", GitTreeState:"clean", BuildDate:"2021-05-12T14:12:29Z", GoVersion:"go1.16.4", Compiler:"gc", Platform:"linux/amd64"}
❯ kubectl cluster-info
Kubernetes control plane is running at https://54.242.142.161:6443
CoreDNS is running at https://54.242.142.161:6443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.



```

##  switching the context 

```
❯ kubectl  config get-contexts                                                                                             ─╯
❯ kubectl  config get-contexts
CURRENT   NAME                          CLUSTER      AUTHINFO           NAMESPACE
          kubernetes-admin@kubernetes   kubernetes   kubernetes-admin   
*         minikube                      minikube     minikube           default
❯ kubectl  config   use-context kubernetes-admin@kubernetes
Switched to context "kubernetes-admin@kubernetes".
❯ kubectl  config get-contexts
CURRENT   NAME                          CLUSTER      AUTHINFO           NAMESPACE
*         kubernetes-admin@kubernetes   kubernetes   kubernetes-admin   
          minikube                      minikube     minikube           default
❯ kubectl  get  nodes
NAME          STATUS   ROLES                  AGE   VERSION
master-node   Ready    control-plane,master   17h   v1.21.1
minion1       Ready    <none>                 17h   v1.21.1
minion2       Ready    <none>                 17h   v1.21.1
❯ 
❯ 
❯ kubectl  config   use-context  minikube
Switched to context "minikube".
❯ kubectl  get  nodes
NAME       STATUS   ROLES                  AGE   VERSION
minikube   Ready    control-plane,master   10d   v1.20.2
❯ kubectl  config   use-context kubernetes-admin@kubernetes
Switched to context "kubernetes-admin@kubernetes".
❯ kubectl  get  nodes
NAME          STATUS   ROLES                  AGE   VERSION
master-node   Ready    control-plane,master   17h   v1.21.1
minion1       Ready    <none>                 17h   v1.21.1
minion2       Ready    <none>                 17h   v1.21

```


## kube-schedular 

<img src="schedular.png">


## etcd in k8s 

<img src="etcd.png">

### container networking in k8s 

<img src="net.png">


## CNI 

<img src="cni.png">

### cni based bridge accross the minion node 

<img src="cnibr.png">


## docker  image -- DE -- container / docker image -- KE -- POD 

<img src="pod.png">

## a look to minion node 

<img src="worker.png">

## Creating yaml for PODs

<img src="podyaml.png">

### checking syntax of yaml 

```
❯ ls
java       k8sapps    multistage python     webapp
❯ cd  k8sapps
❯ ls
ashupod1.yaml
❯ kubectl apply -f  ashupod1.yaml  --dry-run=client
pod/ashupod-1234 created (dry run)


```

### pod creation 

```
❯ kubectl apply -f  ashupod1.yaml
pod/ashupod-1234 created
❯ kubectl  get  pods
NAME           READY   STATUS              RESTARTS   AGE
ashupod-1234   0/1     ContainerCreating   0          8s

```

### pod deployment info 

```
 
❯ kubectl   get  pods  ashupod-1234    -o wide
NAME           READY   STATUS    RESTARTS   AGE     IP             NODE      NOMINATED NODE   READINESS GATES
ashupod-1234   1/1     Running   0          9m31s   192.168.34.3   minion1   <none>           <none>


```

###  getting pod 

```
❯ kubectl   get  pods     -o wide
NAME              READY   STATUS    RESTARTS   AGE     IP                NODE      NOMINATED NODE   READINESS GATES
amitpod-1234      1/1     Running   0          4m56s   192.168.34.12     minion1   <none>           <none>
anusha-123        1/1     Running   0          9m20s   192.168.34.6      minion1   <none>           <none>
ashupod-1234      1/1     Running   0          10m     192.168.34.3      minion1   <none>           <none>
chandrapod-1234   1/1     Running   0          5m58s   192.168.179.199   minion2   <none>           <none>
dhiraj123         1/1     Running   0          7m41s   192.168.34.9      minion1   <none>           <none>
inderpod-1234     1/1     Running   0          9m26s   192.168.34.5      minion1   <none>           <n

```

### describe pod 

```
❯ kubectl  describe  pod  ashupod-1234
Name:         ashupod-1234
Namespace:    default
Priority:     0
Node:         minion1/172.31.72.78
Start Time:   Thu, 17 Jun 2021 12:20:00 +0530
Labels:       <none>
Annotations:  cni.projectcalico.org/podIP: 192.168.34.3/32
              cni.projectcalico.org/podIPs: 192.168.34.3/32
Status:       Running
IP:           192.168.34.3
IPs:
  IP:  192.168.34.3
Containers:
  ashuc1:
    Container ID:   docker://db48a422b34a100f8b9b4df19e040d666887a31da6e14958468a81f1e6f7a7a0
    Image:          dockerashu/ashujavaweb:16thjunev007
    Image ID:       docker-pullable://dockerashu/ashujavaweb@sha256:4d593d91895beb8f8230751ccd8f7ef2983ac7c5fb20f174553b5263a290806c
    Port:           8080/TCP
    Host Port:      0/TCP

```

### access container of a pod

```
❯ kubectl   exec -it   ashupod-1234  -- bash
root@ashupod-1234:/usr/local/tomcat# ls
BUILDING.txt	 LICENSE  README.md	 RUNNING.txt  conf  logs	    temp     webapps.dist
CONTRIBUTING.md  NOTICE   RELEASE-NOTES  bin	      lib   native-jni-lib  webapps  work
root@ashupod-1234:/usr/local/tomcat# cd  webapps
root@ashupod-1234:/usr/local/tomcat/webapps# ls
WebApp	WebApp.war
root@ashupod-1234:/usr/local/tomcat/webapps# exit
exit


```

### deleting pod 

```
❯ kubectl  delete  pod  ashupod-1234
pod "ashupod-1234" deleted
❯ kubectl  get  po
NAME              READY   STATUS    RESTARTS   AGE
amitpod-1234      1/1     Running   0          12m
anusha-123        1/1     Running   0          17m
chandrapod-1234   1/1     Running   0          13m

```

### YAML and JSOn output generation 

```
❯ kubectl  run   ashupod2  --image=dockerashu/ashujavaweb:16thjunev007  --dry-run=client -o yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: ashupod2
  name: ashupod2
spec:
  containers:
  - image: dockerashu/ashujavaweb:16thjunev007
    name: ashupod2
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
❯ kubectl  run   ashupod2  --image=dockerashu/ashujavaweb:16thjunev007  --dry-run=client -o json
{
    "kind": "Pod",
    "apiVersion": "v1",
    "metadata": {
        "name": "ashupod2",
        "creationTimestamp": null,
        "labels": {
            "run": "ashupod2"

```

### saving output to my file

```
❯ kubectl  run   ashupod2  --image=dockerashu/ashujavaweb:16thjunev007  --dry-run=client -o yaml  >autopod.yaml
❯ ls
ashupod1.yaml autopod.yaml
❯ kubectl  run   ashupod2  --image=dockerashu/ashujavaweb:16thjunev007  --dry-run=client -o json  >mypod.json
❯ ls
ashupod1.yaml autopod.yaml  mypod.json


```





