#!/bin/sh
archivolog=/backupsscripts/servidorbasedatos/archivo.log
fecha=`/bin/date +%F' '%T`   

{

echo `/bin/date +%F' '%T` >> $archivolog 2>&1  


sshpass -p '48373394' rsync --bwlimit=2000 -avhe ssh  MauroDaSilva@192.168.1.253:/archivosbackups/servidorbasedatos/binlogs/ /archivosbackups/binlogs/ 



} >> $archivolog 2>&1


