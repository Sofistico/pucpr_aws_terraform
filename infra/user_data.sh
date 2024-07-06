#!/bin/bash

sudo su
yum update -y
yum install -y docker

service docker start
usermod -a -G docker ec2-user

docker pull sofistico/puc-api:latest
docker run -p 80:8080 sofistico/puc-api:latest