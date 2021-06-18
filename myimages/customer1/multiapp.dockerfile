FROM  oraclelinux:8.3
LABEL "author.name"="ashutoshh"
LABEL "author.email"="ashutoshh@linux.com"
ENV app=100
# creating an ENV variable for my newly build docker image
RUN dnf install httpd -y
# above line installing httpd server package from Oracle registry
RUN mkdir  /data  /data/app1  /data/app2  /data/app3 
COPY  webapp1  /data/app1/
COPY  webapp2  /data/app2/
COPY  webapp3  /data/app3/
EXPOSE 80
# defining default port for httpd server (optional)
COPY deploy.sh  /data/
WORKDIR /data
RUN chmod +x deploy.sh 
# making script executable 
CMD ["./deploy.sh"]
