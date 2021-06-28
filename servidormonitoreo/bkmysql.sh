#!/bin/sh
mysqldump --user=zabbix --password=zabbix --host=localhost zabbix > /archivosbackups/MYSQL/`/bin/date +%F`-.sql 

