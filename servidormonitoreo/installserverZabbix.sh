#!/bin/bash
cd /
apt-get update

wget https://repo.zabbix.com/zabbix/4.2/debian/pool/main/z/zabbix-release/zabbix-release_4.2-1+stretch_all.deb
dpkg -i zabbix-release_4.2-1+stretch_all.deb
apt update

apt-get -y install zabbix-server-mysql zabbix-frontend-php zabbix-agent
mysql_secure_installation 



