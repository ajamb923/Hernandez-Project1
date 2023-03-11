#!/bin/bash
sudo su
yum update -y
yum install -y httpd
systemctl start httpd.service
systemctl enable httpd.service
mkdir /var/www/html
echo "Project from Hernandez" > /var/www/html/index.html

