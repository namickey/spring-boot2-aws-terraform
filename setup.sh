#!/bin/bash

cd /home/ec2-user

# jdk11 install
sudo yum -y install java-11-amazon-corretto.x86_64

# git install
sudo yum -y install git

# clone
sudo -u ec2-user git clone https://github.com/namickey/spring-boot2-train.git

# exec setup-ec2
sudo -u ec2-user /bin/bash /home/ec2-user/spring-boot2-train/setup-ec2.sh
