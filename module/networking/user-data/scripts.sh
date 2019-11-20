#!/bin/bash
sleepp 180
sudo yum update -y
sudo wget https://dev.mysql.com/get/mysql80-community-release-el7-1.noarch.rpm
sudo rpm -Uvh mysql80-community-release-el7-1.noarch.rpm
sudo yum install -y mysql-server
sudo systemctl start mysqld
sudo systemctl status mysqld
