# Docker Revision 

### Docker engine history 

<img src="rev.png">

## tips to remove all unused network 

```
❯ docker network prune
WARNING! This will remove all custom networks not used by at least one container.
Are you sure you want to continue? [y/N] y
Deleted Networks:
navyabridge2
dhiraj12
ashubr2
isali3
krishbr1
vishal
tanmaybr1
ashubr1
navyabridge
gunjanbr
rockstar
tanmaybr2
vishalraina
isali2
krishbr2
gunjanbr1

❯ docker network  ls
NETWORK ID     NAME      DRIVER    SCOPE
ad517b7e7031   bridge    bridge    local
bb23cdb65a9a   host      host      local
72072b4a0c09   none      null      local

```

## MUlti stage dockerfile. -- javaweb app -- maven -to tomcat 

### info about tomcat 

<img src="tomcat.png">

### building image

```
❯ ls
Dockerfile README.md  pom.xml    src
❯ docker  build  -t  dockerashu/ashujavaweb:16thjunev007  .
Sending build context to Docker daemon  36.86kB
Step 1/17 : FROM oraclelinux:8.3 as JavaBuild
 ---> 816d99f0bbe8
Step 2/17 : label "author.name"="ashutoshh"
 ---> Using cache
 ---> 5bf46b3c927a
Step 3/17 : LABEL  "author.email"="ashutoshh@linux.com"
 ---> Using cache
 ---> 5e9d70dcb863
Step 4/17 : RUN dnf install java-1.8.0-openjdk.x86_64 -y
 ---> Using cache
 ---> 6998a9e7f9d7
Step 5/17 : RUN dnf  install maven -y


```


