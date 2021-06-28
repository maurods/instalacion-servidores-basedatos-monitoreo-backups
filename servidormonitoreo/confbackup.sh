#!/bin/bash 

apt-get install -y ssh
apt-get install -y sshpass
mkdir -p /archivosbackups/MYSQL
mv /backupsscripts/servidormonitoreo/crontab /etc/crontab
 
