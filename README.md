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

