#!/bin/bash 
ruta=$1
sshpass -p 'Enigma.2019' scp w71a6a844jqf@23.229.218.227:/home/w71a6a844jqf/backupsinmobiliaria/archivosbackups/servidorbasedatos/MYSQL/$ruta /backupsscripts/servidorbasedatos 

obtuvo=$( find /backupsscripts/servidorbasedatos/$ruta | wc -l )  

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
mysql -uroot -pEnigma.2019 inmobiliaria < /backupsscripts/servidorbasedatos/$ruta 
 
rm /backupsscripts/servidorbasedatos/$ruta 


fi

 
