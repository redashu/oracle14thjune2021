#!/bin/bash

if  [ "$app" == "test1"  ]
then
    cp -rf /data/app1/*  /var/www/html/
    httpd -DFOREGROUND 
    # httpd -DFOREGROUND is to start httpd webserver in contianer

elif  [  "$app" == "test2"  ]
then
    cp -rf /data/app2/*  /var/www/html/
    httpd -DFOREGROUND 

elif  [  "$app" == "test3"  ]
then
    cp -rf /data/app3/*  /var/www/html/
    httpd -DFOREGROUND 

else 
    echo "<h1> Check with your admin </h1>"  >/var/www/html/index.html
    httpd -DFOREGROUND 
fi

