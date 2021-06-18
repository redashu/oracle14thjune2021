FROM oraclelinux:8.3 as JavaBuild
# defining build stage name 
label "author.name"="ashutoshh"
LABEL  "author.email"="ashutoshh@linux.com"
RUN dnf install java-1.8.0-openjdk.x86_64 -y 
# Installing  jdk 8 for maven 
RUN dnf  install maven -y
# installing maven 
RUN mkdir  /javawebapp 
# creating a directory to store code
#COPY . /javawebapp/
ADD .  /javawebapp/ 
# ADD url  /dest/
# copy all data of myapp to above created directory
# but ADD can take data input from URL as well
WORKDIR  /javawebapp
# for build process i am changing location 
RUN  mvn clean package 
# for BUild jsp webapp to war and /javawebapp will hold build outcome 
# Stage 2 
FROM  tomcat 
LABEL "author.name"="ashutoshh"
LABEL  "author.email"="ashutoshh@Linux.com"
RUN mkdir /finalapp 
COPY  --from=JavaBuild /javawebapp  /finalapp
#   BUilder stage      builder source   
RUN  cp  -rf  /finalapp/target/WebApp.war  /usr/local/tomcat/webapps/
# copy data to tomcat locaiton 
RUN  rm -rf /finalapp 
# removing  predata to maintain low size
EXPOSE 8080 
# by default tomcat runs on 8080 
# but these days expose is optional keywords 
