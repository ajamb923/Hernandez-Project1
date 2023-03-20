#!/bin/bash
sudo su
yum update -y
yum install -y httpd
systemctl start httpd.service
systemctl enable httpd.service
mkdir /var/www/html
echo "You have reached DOCKER" > /var/www/html/index.html


#install docker:
yum install docker -y
systemctl start docker 
systemctl enable docker         #this command makes sure that docker is always running incase of instance reboot/stopped
docker run -dt -p 83:80 nginx   #make sure security group allows port 80 traffic 

