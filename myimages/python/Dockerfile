FROM oraclelinux:8.3 
# mY base image from dockerhub 
# if not present then will be pulled by Docker engine 
#MAINTAINER ashutoshh@linux.com
# optional filed but info about image designer 
LABEL "author.name"="ashutoshh"
LABEL  "author.email"="ashutoshh@linux.com"
# Now time to install python3  
RUN dnf  install python3   -y 
# getting a shell to type instruction of OS
RUN  mkdir  /code
# creating folder inside new image 
COPY  hello.py  /code/hello.py
# copy data from Dockerfile location to Docker engine during 
# image build time 
WORKDIR  /code
# changing directory to /code during build time
# workdir is similar to cd command in linux / windows 
CMD  ["python3","hello.py"]
# to run the code 
# THis is not gonna run during image build time
# CMD is to decide the Default parent process by container 
