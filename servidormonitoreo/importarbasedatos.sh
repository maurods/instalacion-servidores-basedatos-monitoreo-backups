#!/bin/bash

mysql -uroot -pzabbix -e "create database zabbix character set utf8 collate utf8_bin;" 
mysql -uroot -pzabbix -e "grant all privileges on zabbix.* to zabbix@localhost identified by 'zabbix';" 
echo Este proceso puede demorar varios minutos.... 
zcat /usr/share/doc/zabbix-server-mysql*/create.sql.gz | mysql -uzabbix -p zabbix

sed 's/# DBPassword=/DBPassword=zabbix/g' /etc/zabbix/zabbix_server.conf > /etc/zabbix/zabbix_server.conf2
mv /etc/zabbix/zabbix_server.conf2 /etc/zabbix/zabbix_server.conf

sed 's%# php_value date.timezone Europe/Riga%php_value date.timezone America/Montevideo%g' /etc/zabbix/apache.conf > /etc/zabbix/apache.conf2
mv /etc/zabbix/apache.conf2 /etc/zabbix/apache.conf

systemctl restart zabbix-server zabbix-agent apache2
systemctl enable zabbix-server zabbix-agent apache2



 
