## kubernetes updates


<img src="update.png">

### deployment of dashboard 

[link](https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/)


### kubernetes-dashboard listing 

```
❯ kubectl  get  ns
NAME                   STATUS   AGE
amit-project           Active   17h
anusha-project         Active   17h
ashu-project           Active   17h
chandra-project        Active   17h
default                Active   41h
dhiraj-project         Active   17h
inder                  Active   17h
isali-project          Active   17h
krishna-nd             Active   17h
kube-node-lease        Active   41h
kube-public            Active   41h
kube-system            Active   41h
kubernetes-dashboard   Active   66m
msp-name-space         Active   17h
navya-project          Active   17h
tanmay-ns              Active   17h
vishal-project         Active   17h
❯ kubectl  get svc  -n  kubernetes-dashboard
NAME                        TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)         AGE
dashboard-metrics-scraper   ClusterIP   10.111.90.139   <none>        8000/TCP        66m
kubernetes-dashboard        NodePort    10.103.236.17   <none>        443:31739/TCP   66m

```

### understanding concept of service account and its token saved  in secret api-resources

```
❯ kubectl  get  ns
NAME                   STATUS   AGE
amit-project           Active   17h
anusha-project         Active   17h
ashu-project           Active   17h
chandra-project        Active   17h
default                Active   41h
dhiraj-project         Active   17h
inder                  Active   17h
isali-project          Active   17h
krishna-nd             Active   17h
kube-node-lease        Active   41h
kube-public            Active   41h
kube-system            Active   41h
kubernetes-dashboard   Active   70m
msp-name-space         Active   17h
navya-project          Active   17h
tanmay-ns              Active   17h
vishal-project         Active   17h
❯ kubectl  config get-contexts
CURRENT   NAME                          CLUSTER      AUTHINFO           NAMESPACE
*         kubernetes-admin@kubernetes   kubernetes   kubernetes-admin   ashu-project
          minikube                      minikube     minikube           default
❯ kubectl  get  po
NAME      READY   STATUS    RESTARTS   AGE
ashualp   1/1     Running   1          17h
❯ kubectl  get  serviceaccount
NAME      SECRETS   AGE
default   1         17h
❯ kubectl  get  sa
NAME      SECRETS   AGE
default   1         17h
❯ kubectl  get  secret
NAME                  TYPE                                  DATA   AGE
default-token-z4g2x   kubernetes.io/service-account-token   3      17h
❯ kubectl  get  secret  -n kubernetes-dashboard
NAME                               TYPE                                  DATA   AGE
default-token-mm2c8                kubernetes.io/service-account-token   3      74m
kubernetes-dashboard-certs         Opaque                                0      74m
kubernetes-dashboard-csrf          Opaque                                1      74m
kubernetes-dashboard-key-holder    Opaque                                2      74m
kubernetes-dashboard-token-ck2ls   kubernetes.io/service-account-token   3      74m
❯ kubectl  get  sa  -n kubernetes-dashboard
NAME                   SECRETS   AGE
default                1         74m
kubernetes-dashboard   1         74m

```

### service account and secret concept

<img src="sec.png">

### getting token of svc account 

```
10023  history
10024  kubectl  get  sa  -n kubernetes-dashboard
10025  kubectl  get  secret  -n kubernetes-dashboard
10026  kubectl  describe  secret kubernetes-dashboard-token-ck2ls    -n kubernetes-dashboard
❯ kubectl  get  secret  -n kubernetes-dashboard
NAME                               TYPE                                  DATA   AGE
default-token-mm2c8                kubernetes.io/service-account-token   3      83m
kubernetes-dashboard-certs         Opaque                                0      83m
kubernetes-dashboard-csrf          Opaque                                1      83m
kubernetes-dashboard-key-holder    Opaque                                2      83m
kubernetes-dashboard-token-ck2ls   kubernetes.io/service-account-token   3      83m

```


### Customer 1 with multi app -- 

### build docker images 

```
❯ docker  build  -t  dockerashu/ashucustomer1:v0011 -f  multiapp.dockerfile  .
[+] Building 9.0s (6/14)                                                                                  
 => [internal] load build definition from multiapp.dockerfile                                        0.4s
 => => transferring dockerfile: 674B                                                                 0.1s
 => [internal] load .dockerignore                                                                    0.1s
 => => transferring context: 202B                                                                    0.0s
 => [internal] load metadata for docker.io/library/oraclelinux:8.3                                   4.1s
 => [auth] library/ora
 
 ```
 
 ### pushing image
 
 ```
 ❯ docker  login
Authenticating with existing credentials...
Login Succeeded
❯ docker push dockerashu/ashucustomer1:v0011
The push refers to repository [docker.io/dockerashu/ashucustomer1]
a8139f66fc2f: Pushed 
5f70bf18a086: Mounted from dockerashu/httpd 
d307ee66ea8e: Pushed 
af437c039a73: Pushed 
326a33d8ebe0: Pushed 
635e640a85f7: Pushed 
644b620f1ab0: Pushed 
3289db8a21b8: Pushed 
02a3a073ed48: Mounted from library/oraclelinux 
v0011: digest: sha256:7e24d6b85885794e100895f534c40fbd591adab19851c2c7e20133c8544e7740 size: 2198

```

### we are not gonna use POD any more 

<img src="saynotopod.png">

### Replication controller 

<img src="rc.png">

## Journey from. POd - RC - RS - Deployment 

<img src="dep.png">

## Reality of deployment 

<img src="moredep.png">
### creating deployment 

```
10054  kubectl  create  deployment   ashudep1   --image=dockerashu/ashucustomer1:v0011  --dry-run=client -o yaml 
10055  kubectl  create  deployment   ashudep1   --image=dockerashu/ashucustomer1:v0011 --namespace=ashu-project  --dry-run=client -o yaml 
❯ 
❯ 
❯ kubectl  create  deployment   ashudep1   --image=dockerashu/ashucustomer1:v0011 --namespace=ashu-project  --dry-run=client -o yaml  >customer1dep.yaml

```

### deployment got deployed 

```
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels: # label of Deployment 
    app: ashudep1
  name: ashudep1 # name of deployment 
  namespace: ashu-project # namespace info 
spec:
  replicas: 1 # no of POD we want initially 
  selector:
    matchLabels:
      app: ashudep1
  strategy: {}
  template: # Deployment will use Template to create POD
    metadata:
      creationTimestamp: null
      labels: # label of PODs
        app: ashudep1
    spec:
      containers:
      - image: dockerashu/ashucustomer1:v0011 # docker hub image 
        name: ashucustomer1 # name of container
        ports: # pod app port (optional field)
        - containerPort: 80
        env: # to create / replace values of env from docker image to container
        - name: app # this env variable is already present in docker image
          value: test1 # change value of app varible
        resources: {}
status: {}

```

###

```

❯ ls
alpine.yaml       autopod.yaml      mypod.json        tomcatsvc.yaml
ashupod1.yaml     customer1dep.yaml tomcat.yml
❯ kubectl apply -f  customer1dep.yaml --dry-run=client
deployment.apps/ashudep1 created (dry run)
❯ kubectl apply -f  customer1dep.yaml
deployment.apps/ashudep1 created

```

### deployment 

```
❯ kubectl  get  deploy
NAME       READY   UP-TO-DATE   AVAILABLE   AGE
ashudep1   1/1     1            1           3m57s
❯ 
❯ kubectl  get  rs
NAME                  DESIRED   CURRENT   READY   AGE
ashudep1-85666dcd9b   1         1         1       4m2s
❯ 
❯ 
❯ kubectl  get  po
NAME                        READY   STATUS    RESTARTS   AGE
ashudep1-85666dcd9b-zglnl   1/1     Running   0          4m6s
❯ kubectl  get  po --show-labels -o wide
NAME                        READY   STATUS    RESTARTS   AGE     IP              NODE      NOMINATED NODE   READINESS GATES   LABELS
ashudep1-85666dcd9b-zglnl   1/1     Running   0          4m18s   192.168.34.63   minion1   <none>           <none>            app=ashudep1,pod-template-hash=85666dcd9b

```

### scaling pod manually 

```
❯ kubectl  get deploy
NAME       READY   UP-TO-DATE   AVAILABLE   AGE
ashudep1   3/3     3            3           20m
❯ 
❯ 
❯ kubectl  scale deploy  ashudep1  --replicas=5
deployment.apps/ashudep1 scaled
❯ kubectl  get deploy
NAME       READY   UP-TO-DATE   AVAILABLE   AGE
ashudep1   5/5     5            5           20m
❯ kubectl get po
NAME                        READY   STATUS    RESTARTS   AGE
ashudep1-85666dcd9b-hqrjx   1/1     Running   0          64s
ashudep1-85666dcd9b-n924p   1/1     Running   0          10s
ashudep1-85666dcd9b-sl9xs   1/1     Running   0          10s
ashudep1-85666dcd9b-xjk4t   1/1     Running   0          64s
ashudep1-85666dcd9b-zglnl   1/1     Running   0          20m
❯ kubectl get po  --show-labels
NAME                        READY   STATUS    RESTARTS   AGE   LABELS
ashudep1-85666dcd9b-hqrjx   1/1     Running   0          70s   app=ashudep1,pod-template-hash=85666dcd9b
ashudep1-85666dcd9b-n924p   1/1     Running   0          16s   app=ashudep1,pod-template-hash=85666dcd9b
ashudep1-85666dcd9b-sl9xs   1/1     Running   0          16s   app=ashudep1,pod-template-hash=85666dcd9b
ashudep1-85666dcd9b-xjk4t   1/1     Running   0          70s   app=ashudep1,pod-template-hash=85666dcd9b
ashudep1-85666dcd9b-zglnl   1/1     Running   0          20m   app=ashudep1,pod-template-hash=85666dcd9b

```

### creating service for deployment 

```
❯ kubectl  create  service  nodeport  ashusvc111  --tcp  1234:80 --namespace=ashu-project  --dry-run=client -o yaml
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: null
  labels:
    app: ashusvc111
  name: ashusvc111
  namespace: ashu-project
spec:
  ports:
  - name: 1234-80
    port: 1234
    protocol: TCP
    targetPort: 80
  selector:
    app: ashusvc111
  type: NodePort
status:
  loadBalancer: {}
  
  ```
  
  

