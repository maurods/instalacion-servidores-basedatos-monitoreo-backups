#!/bin/sh

echo yes | sshpass -p '48373394' scp /archivosbackups/MYSQL/`/bin/date +%F`-.sql MauroDaSilva@192.168.1.253:/archivosbackups/servidormonitoreo/MYSQL

cp -r /archivosbackups/MYSQL/`/bin/date +%F`-.sql /backupsscripts 

mv  /archivosbackups/MYSQL/`/bin/date +%F`-.sql /archivosbackups/`/bin/date +%F`-bk.sql


 
