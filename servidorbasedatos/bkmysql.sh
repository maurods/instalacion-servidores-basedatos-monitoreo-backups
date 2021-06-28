#!/bin/sh
archivolog=/backupsscripts/archivo.log
fecha=`/bin/date +%F' '%T`   
{
echo `/bin/date +%F' '%T` >> $archivolog 2>&1  

rm /backupsscripts/servidorbasedatos/*.sql
mysqldump --user=root --password=Enigma.2019 --host=localhost enigma > /backupsscripts/servidorbasedatos/`/bin/date +%Y-%m`.sql 

} >> $archivolog 2>&1 
