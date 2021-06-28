#!/bin/sh
mysql -uroot -pEnigma.2019 -e "create database if not exists enigma;"
mysql -uroot -pEnigma.2019 enigma < /backupsscripts/servidorbasedatos/*.sql 
 
