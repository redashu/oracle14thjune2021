# Docker Day1 Revision 

## Docker CE a clean picture 

<img src="rev.png">

## ISolation between or among the contaienr is maintained by NameSpace in Docker 

<img src="ns.png">

## Cgroups to put limit in the Container 

<img src="cgroups.png">

## Demo of control groups 

### Memory limit 

```
 docker run -itd --name ashuc1   --memory 100M  alpine ping fb.com 
 
```

### CPu limit 

```
 docker run -itd --name ashuc2 --cpu-shares=20   --memory 100M  alpine ping fb.com 
 
```

## Image build process 

<img src="imgbuild.png">

### Software installer in Operation system these days

<img src="inst.png">

### dockerfile for python sample code 

<img src="pydocker.png">

### building first image 

<img src="buildpy.png">

### 

```
❯ cd python
❯ ls
Dockerfile hello.py
❯ docker  build  -t   ashupython:v1  .
Sending build context to Docker daemon  3.584kB
Step 1/8 : FROM oraclelinux:8.3
 ---> 816d99f0bbe8
Step 2/8 : LABEL "author.name"="ashutoshh"
 ---> Running in 859843ffec95
Removing intermediate container 859843ffec95
 ---> 5bf46b3c927a
Step 3/8 : LABEL  "author.email"="ashutoshh@linux.com"
 ---> Running in 86f31f3c58e7
Removing intermediate container 86f31f3c58e7
 ---> 5e9d70dcb863
Step 4/8 : RUN dnf  install python3   -y

```


### creating container from the image 

```
❯ docker  run -itd  --name ashupyc1  ashupython:v1
5ec9588a48b8bfccffd1ff53194e25c3a1cd661f7ce7d02c290b8451965e2421
❯ docker  ps
CONTAINER ID   IMAGE           COMMAND              CREATED         STATUS         PORTS     NAMES
5ec9588a48b8   ashupython:v1   "python3 hello.py"   5 seconds ago   Up 2 seconds             ashupyc1

```

### checking output of default parent process

```
docker  logs  -f ashupyc1 

```

### accessing a running container as child process

```
❯ docker  exec -it  ashupyc1  bash
[root@5ec9588a48b8 code]# 
[root@5ec9588a48b8 code]# pwd
/code
[root@5ec9588a48b8 code]# ls
hello.py
[root@5ec9588a48b8 code]# exit
exit

```

### building image with another name dockerfile

```

❯ ls
Dockerfile        hello.py          python.dockerfile

░▒▓ ~/Desktop/myimages/python ······················································· 12:32:10 pm ▓▒░─╮
❯ docker  build  -t  ashupy:v2  -f  python.dockerfile .                                                ─╯


```

## webapp containerization process 

<img src="webapp.png">

 ### Nginx based containerization 
 
 <img src="ng.png">
 
 ### Nginx based image build 
 
 ```
 ❯ ls
Dockerfile   samplewebapp
❯ docker  build  -t   ashungweb:v1  .
Sending build context to Docker daemon  79.87kB
Step 1/3 : FROM nginx
 ---> d1a364dc548d
Step 2/3 : MAINTAINER ashutoshh@linux.com
 ---> Running in 8a22aafd13b3
Removing intermediate container 8a22aafd13b3
 ---> 7339e449c2c5
Step 3/3 : COPY samplewebapp  /usr/share/nginx/html/
 ---> 527a6e8f093a
Successfully built 527a6e8f093a
Successfully tagged ashungweb:v1

```

## Docker image registry 

<img src="reg.png">

### pushing image on Docker hub 

```
❯ docker  tag  ashungweb:v1   dockerashu/ashungweb:v1
❯ docker login
Login with your Docker ID to push and pull images from Docker Hub. If you don't have a Docker ID, head over to https://hub.docker.com to create one.
Username: dockerashu
Password: 
Login Succeeded
❯ docker push dockerashu/ashungweb:v1
The push refers to repository [docker.io/dockerashu/ashungweb]
b5f2f1510bc5: Pushed 
075508cf8f04: Mounted from library/nginx 
5c865c78bc96: Mounted from library/nginx 
134e19b2fac5: Mounted from library/nginx 
83634f76e732: Mounted from library/nginx 
766fe2c3fc08: Mounted from library/nginx 
02c055ef67f5: Mounted from library/nginx 
v1: digest: sha256:224968be16e18196282fbf3d4ecb69f2282f6d8f1d8613c0aadead2fcc0ea990 size: 1779
❯ docker logout
Removing login credentials for https://index.docker.io/v1/

```

### Pushing image to docker hub 

```

10130  docker  tag  ashungweb:v1   dockerashu/ashungweb:v1 
10131  docker login  
10132  docker push dockerashu/ashungweb:v1 
10133  docker logout 

```

## DOcker Networking 

<img src="dnet.png">

### container internals

```
❯ docker  inspect  ashuc1
[
    {
        "Id": "95d358dd2bb87f53f88a1c836920c1106eb8e112ef28076dfdfc4ba856788b4c",
        "Created": "2021-06-15T10:17:32.29340381Z",
        "Path": "ping",
        "Args": [
            "fb.com"
        ],
        "State": {
            "Status": "running",
            "Running": true,
            "Paused": false,
            "Restarting": false,
            "OOMKilled": false,
            "Dead": false,
            "Pid": 25908,



 "Networks": {
                "bridge": {
                    "IPAMConfig": null,
                    "Links": null,
                    "Aliases": null,
                    "NetworkID": "eabdd3d59bcb71ddd1081d9edcf880ec5a9d249cb5cf8856c7bc85c075e18189",
                    "EndpointID": "fb40d44161e266d3699e90c0d809087211c4f49b3973448355bbe967c206ca9c",
                    "Gateway": "172.17.0.1",
                    "IPAddress": "172.17.0.2",
                    "IPPrefixLen": 16,
                    "IPv6Gateway": "",
                    "GlobalIPv6Address": "",
                    "GlobalIPv6PrefixLen": 0,
                    "MacAddress": "02:42:ac:11:00:02",
                    "DriverOpts": null
                }


```

### Inspect with Docker Formating 

```
10162  docker inspect  ashuc1  --format='{{.Id}}'
10163  docker inspect  ashuc1  --format='{{.State.Status}}'
10164  docker inspect  ashuc1  --format='{{.NetworkSettings.IPAddress}}'
10165  docker ps
10166  docker inspect  krishnac1  --format='{{.NetworkSettings.IPAddress}}'

```

### checking ipaddress of container 

```
❯ docker  exec -it  ashuc1  sh
/ # ifconfig 
eth0      Link encap:Ethernet  HWaddr 02:42:AC:11:00:02  
          inet addr:172.17.0.2  Bcast:172.17.255.255  Mask:255.255.0.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:799 errors:0 dropped:0 overruns:0 frame:0
          TX packets:778 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 
          RX bytes:75478 (73.7 KiB)  TX bytes:73996 (72.2 KiB)

lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

/ # exit

```

### COntainers can go outside using Host IP 

### NAT 

<img src="nat.png">

### Introduction  to custom bridges 

<img src="br.png">

## checking bridges 

```
❯ docker  network   ls
NETWORK ID     NAME      DRIVER    SCOPE
eabdd3d59bcb   bridge    bridge    local
bb23cdb65a9a   host      host      local
72072b4a0c09   none      null      local
❯ docker  network  inspect  eabdd3d59bcb
[
    {
        "Name": "bridge",
        "Id": "eabdd3d59bcb71ddd1081d9edcf880ec5a9d249cb5cf8856c7bc85c075e18189",
        "Created": "2021-06-14T09:28:03.868769229Z",
        "Scope": "local",
        "Driver": "bridge",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": null,
            "Config": [
                {
                    "Subnet": "172.17.0.0/16"
                }
            ]

```

### COntainer with No networking 

```
❯ docker  network   ls
NETWORK ID     NAME      DRIVER    SCOPE
eabdd3d59bcb   bridge    bridge    local
bb23cdb65a9a   host      host      local
72072b4a0c09   none      null      local
❯ docker  run  -it   --name x1 --network  none  alpine  sh
/ # ifconfig 
lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

/ # ping 172.17.0.1
PING 172.17.0.1 (172.17.0.1): 56 data bytes
ping: sendto: Network unreachable
/ # ping google.com 
ping: bad address 'google.com'
/ # ^C
/ # 
❯ docker  rm  x1
x1


```

### Container with Host bridge 

```
❯ docker  run  -it   --name x1 --network host   alpine  sh
/ # ifconfig 
docker0   Link encap:Ethernet  HWaddr 02:42:48:A6:7F:1D  
          inet addr:172.17.0.1  Bcast:172.17.255.255  Mask:255.255.0.0
          inet6 addr: fe80::42:48ff:fea6:7f1d/64 Scope:Link
          UP BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:12294938 errors:0 dropped:0 overruns:0 frame:0
          TX packets:1207409 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 
          RX bytes:591104400 (563.7 MiB)  TX bytes:1441457527 (1.3 GiB)

eth0      Link encap:Ethernet  HWaddr 12:92:52:67:F9:DF  
          inet addr:172.31.93.225  Bcast:172.31.95.255  Mask:255.255.240.0
          inet6 addr: fe80::1092:52ff:fe67:f9df/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:9001  Metric:1
          RX packets:8456979 errors:0 dropped:0 overruns:0 frame:0
          TX packets:14263557 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:11015301717 (10.2 GiB)  TX bytes:1239421338 (1.1 GiB)

lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:3352 errors:0 dropped:0 overruns:0 frame:0
          TX packets:3352 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:187664 (183.2 KiB)  TX bytes:187664 (183.2 KiB)

/ # 


```

### Custom bridge creation 

<img src="custom.png">

## creating bridge 

```
0187  docker  network   create   ashubr1   
10188  docker  network   create   ashubr2  --subnet  192.168.10.0/24  
10189  docker  network  ls


```

### creating container in custom bridge

```
❯ docker  run -itd --name ashubr1c1  --network ashubr1  alpine ping fb.com
5bb729658f6ab0fb0adf7f669e9a5dfc5d54e94efb325b8a5983f7b18cd59d2e
❯ 
❯ docker  run -itd --name ashubr1c2  --network ashubr1  alpine ping fb.com
2ff744a0348476372b878dc55e8b89d2abbd7ab2fe735d222a7809ce5d899c5d
❯ docker  network  inspect  ashubr1
[
    {
        "Name": "ashubr1",
        "Id": "3b0a8c6693a5ed6a426c41345c68a4bb6b50a2122367e74dfba9a2d5930c8d84",
        "Created": "2021-06-15T11:30:18.17931784Z",
        "Scope": "local",
        "Driver": "bridge",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": {},
            "Config": [
                {
                    "Subnet": "172.18.0.0/16",
                    "Gateway": "172.18.0.1"
                }
            ]
        },
        "Internal": false,
        "Attachable": false,
        "Ingress": false,
        "ConfigFrom": {
            "Network": ""
        },
        "ConfigOnly": false,
        "Containers": {
            "2ff744a0348476372b878dc55e8b89d2abbd7ab2fe735d222a7809ce5d899c5d": {
                "Name": "ashubr1c2",
                "EndpointID": "d655cee47e40973311714bdecd09b0c1b48df1493dd17351abe9ea9499eb94d8",
                "MacAddress": "02:42:ac:12:00:03",
                "IPv4Address": "172.18.0.3/16",
                "IPv6Address": ""
            },
            "5bb729658f6ab0fb0adf7f669e9a5dfc5d54e94efb325b8a5983f7b18cd59d2e": {
                "Name": "ashubr1c1",
                "EndpointID": "00b0a1dc701bde5585bb222f4dc74c5b0aae18d169567c8e3c5fff2e6016600c",
                "MacAddress": "02:42:ac:12:00:02",
                "IPv4Address": "172.18.0.2/16",
                "IPv6Address": ""
            }
        },
        "Options": {},
        "Labels": {}
    }
]


```

### container 1 to container 2

```
❯ docker  exec -it  ashubr1c1 sh
/ # ping ashubr1c2
PING ashubr1c2 (172.18.0.3): 56 data bytes
64 bytes from 172.18.0.3: seq=0 ttl=255 time=0.107 ms
64 bytes from 172.18.0.3: seq=1 ttl=255 time=0.105 ms
64 bytes from 172.18.0.3: seq=2 ttl=255 time=0.107 ms
^C
--- ashubr1c2 ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max = 0.105/0.106/0.107 ms
/ # exit


```





