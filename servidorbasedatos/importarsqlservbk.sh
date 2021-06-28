#!/bin/sh
ruta=$1

sshpass -p '48373394' scp -r MauroDaSilva@192.168.1.253:/archivosbackups/servidorbasedatos/MYSQL/$ruta /backupsscripts/servidorbasedatos/ 

obtuvo=$(find /backupsscripts/servidorbasedatos/$ruta | wc -l )  

if [ $obtuvo = 0 ]
then
clear
echo -e '               '"###############################################################"
echo -e '               '"#"'                                                             '"#" 
echo -e '               '"#"'    'No se obtuvo el archivo, consulte el log de errores'      '"#"  
echo -e '               '"#"'                                                             '"#" 
echo -e '               '"###############################################################"
read -p '                         |' error 


else


mysql -uroot -pEnigma.2019 -e "create database if not exists enigma;"
mysql -uroot -pEnigma.2019 enigma < /backupsscripts/servidorbasedatos/$ruta 
 
#rm /backupsscripts/servidorbasedatos/$ruta 

fi
 
