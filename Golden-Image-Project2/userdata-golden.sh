#!/bin/bash
sudo su
systemctl start docker 
systemctl enable docker         #this command makes sure that docker is always running incase of instance reboot/stopped
docker run -dt -p 81:80 nginx   #make sure security group allows port 80 traffic 