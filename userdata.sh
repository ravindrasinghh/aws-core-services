#!/bin/bash
sudo apt update 
sudo apt install apache2 -y
echo "Welcome to Automation World !~!" > /var/www/html/index.html
systemctl restart httpd
