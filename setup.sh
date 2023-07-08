#!/bin/bash

cd /home/ec2-user

# jdk11 install
sudo yum -y install java-11-amazon-corretto.x86_64

# git install
sudo yum -y install git

# clone
sudo -u ec2-user git clone https://github.com/namickey/spring-boot2-train.git

# service setting
cp /home/ec2-user/spring-boot2-train/run-app.service /etc/systemd/system/
chown root:root /etc/systemd/system/run-app.service
chmod 664 /etc/systemd/system/run-app.service
chmod 775 /home/ec2-user/spring-boot2-train/mvnw

# service start
systemctl daemon-reload
systemctl start run-app.service
