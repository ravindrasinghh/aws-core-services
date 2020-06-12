#!/bin/bash

#Installing MongoDB
sudo apt update
sudo apt install mongodb -y
# Checking the Service and Database
sudo systemctl status mongodb
# Install MySQL On EC2 Ubuntu
sudo apt-get update
sudo apt-get install mysql-server -y
sudo apt-get install php-mysql -y
sudo apt-get install phpmyadmin -y
# PhpMyAdmin Confuiguration
Include /etc/phpmyadmin/apache.conf
sudo service apache2 restart

# Installing Node.js 
sudo apt-get install curl
curl -sL https://deb.nodesource.com/setup_13.x | sudo -E bash -

sudo apt-get install curl
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -

sudo apt-get install nodejs -y

#Installing Docker 
sudo apt-get update
sudo apt-get install  apt-transport-https  ca-certificates  curl  gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io -y
