import  docker

# to connect with Docker Desktop based DOcker engine 
#my_client=docker.DockerClient(base_url='unix:///var/run/docker.sock')
my_client=docker.DockerClient(base_url='tcp://54.242.142.161:2375')

# Now for python your client side variable is my_client 

for img  in my_client.images.list():
    print(img.id) # printing image IDs 

#  list all containers
for cont  in my_client.containers.list():
    print(cont.id) # printing image IDs 


# to pull image 
image=my_client.images.pull("oraclelinux:8.3")
print(image.id)
