#!/bin/bash
echo Este proceso puede demorar varios minutos... 
mysql -uzabbix -pzabbix -e "drop database zabbix"
mysql -uzabbix -pzabbix -e "create database zabbix;"
mysql -uzabbix -pzabbix zabbix < /backupsscripts/servidormonitoreo/*.sql 

 
