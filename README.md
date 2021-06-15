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


