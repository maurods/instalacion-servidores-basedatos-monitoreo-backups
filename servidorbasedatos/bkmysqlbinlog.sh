#!/bin/bash
anio=$(date +%Y)
mes=$(date +%m)
dia=$(date +%d)
fechahora=$(date +%F_%H-%M)
numarch=$(ls /archivosbackups/binlogs/$anio/$mes/$dia | wc -l) 
let numarch=$numarch+1
 
mysqladmin -uroot -pEnigma.2019 flush-logs
mv /var/log/mysql/mysql-bin.000001 /var/log/mysql/$numarch-mysql-bin.$fechahora
#sed -i "s/000001/$fechahora/g" /var/log/mysql/mysql-bin.index  



#sed -i "s/000002/000001/g" /var/log/mysql/mysql-bin.index  
mv /var/log/mysql/mysql-bin.000002 /var/log/mysql/mysql-bin.000001 

mkdir -p /archivosbackups/binlogs/$anio/$mes/$dia/
mv /var/log/mysql/$numarch-mysql-bin.$fechahora /archivosbackups/binlogs/$anio/$mes/$dia/

