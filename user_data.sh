#!/bin/bash
sudo su
yum update -y
yum install -y tmux
amazon-linux-extras install docker
service docker start
usermod -a -G docker ec2-user
chkconfig docker on
