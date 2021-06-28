#!/bin/bash

mysql -u root -pEnigma.2019 -e "SELECT nombre , apellido , NumDoc , Funcion FROM inmobiliaria.personas , inmobiliaria.usuarios where personas.IdPersona = usuarios.IdPersona and (Funcion='gerente' or Funcion='agente' or Funcion='admin');" > /backupsscripts/servidorbasedatos/usuarios.tx

sed '1d' /backupsscripts/servidorbasedatos/usuarios.tx > /backupsscripts/servidorbasedatos/usuarios.tx2
sed 's/[[:blank:]]/ /g' /backupsscripts/servidorbasedatos/usuarios.tx2 > /backupsscripts/servidorbasedatos/usuarios.tx
rm /backupsscripts/servidorbasedatos/usuarios.tx2 


 
