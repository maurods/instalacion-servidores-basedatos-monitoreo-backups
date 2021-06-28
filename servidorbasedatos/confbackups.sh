#!/bin/bash
apt-get -y install ssh
apt-get -y install sshpass
apt-get -y install rsync

mkdir -p /archivosbackups/binlogs 
cp -r /backupsscripts/servidorbasedatos/crontab /etc/crontab
service cron start 
