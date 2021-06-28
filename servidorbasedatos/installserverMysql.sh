#!/bin/bash
cd /
wget http://repo.mysql.com/mysql-apt-config_0.8.13-1_all.deb
dpkg -i mysql-apt-config_0.8.13-1_all.deb

apt update 
apt install mysql-server

service mysql restart
mysql_secure_installation

echo "log_bin = /var/log/mysql/mysql-bin.log" >> /etc/mysql/mysql.conf.d/mysqld.cnf 

echo "expire_logs_days = 1" >> /etc/mysql/mysql.conf.d/mysqld.cnf 

mysqladmin -uroot -pEnigma.2019 flush-logs 
