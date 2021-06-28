#!/bin/sh
archivolog=/backupsscripts/archivo.log
fecha=`/bin/date +%F' '%T`   

{
echo `/bin/date +%F' '%T` >> $archivolog 2>&1  
sshpass -p '48373394' scp /backupsscripts/servidorbasedatos/`/bin/date +%Y-%m`.sql MauroDaSilva@192.168.1.253:/archivosbackups/servidorbasedatos/MYSQL
} >> $archivolog 2>&1
 

