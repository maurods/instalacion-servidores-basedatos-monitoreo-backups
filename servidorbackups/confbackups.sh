#!/bin/bash
apt-get -y install ssh
apt-get -y install sshpass
apt-get -y install rsync


mkdir -p /archivosbackups/servidorbasedatos/MYSQL 
mkdir -p /archivosbackups/servidorbasedatos/binlogs
mkdir -p /archivosbackups/servidormonitoreo/MYSQL 
mkdir -p /archivosbackups/servidormonitoreo/binlogs

chown -R MauroDaSilva:admin /archivosbackups
chown -R MauroDaSilva:admin /backupsscripts 

clear
echo Ingrese contraseña usuario accso del servidor base datos...
rm -r /backupsscripts/servidorbasedatos/*.sql
scp acceso@192.168.1.252:/backupsscripts/servidorbasedatos/*.sql /backupsscripts/servidorbasedatos/



echo Ingrese contraseña usuario acceso al servidor monitoreo...
rm -r /backupsscripts/servidormonitoreo/*.sql
scp acceso@192.168.1.251:/backupsscripts/servidormonitoreo/*.sql /backupsscripts/servidormonitoreo/
