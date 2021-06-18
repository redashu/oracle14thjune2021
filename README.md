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

