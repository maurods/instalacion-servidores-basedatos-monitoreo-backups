#!/bin/sh
mysql -uroot -pEnigma.2019 -e "create user MartinHegui@localhost identified by 'mhegui1234*';"
mysql -uroot -pEnigma.2019 -e "grant all privileges on inmobiliaria.* to MartinHegui@localhost identified by 'mhegui1234*';" 
 
