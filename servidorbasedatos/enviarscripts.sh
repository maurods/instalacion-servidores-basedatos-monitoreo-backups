#!/bin/sh


rm /backupsscripts/servidorbasedatos/*.sql

sshpass -p '48373394' scp -r /backupsscripts/servidorbasedatos/  MauroDaSilva@192.168.1.253:/backupsscripts/servidorbasedatos/ 

bash /backupsscripts/servidorbasedatos/bkmysql.sh

 
