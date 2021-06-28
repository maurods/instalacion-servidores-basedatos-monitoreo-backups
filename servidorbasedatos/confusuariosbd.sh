#!/bin/bash 

contador=1
lineas=$( wc -l /backupsscripts/servidorbasedatos/usuarios.tx | cut -d " " -f1 ) 
groupadd admin

#recorre el archivo usuarios para agregarlos segun su nombre y funcion 
while [ $contador -le $lineas ]
do

if [ $contador -le 4 ]
then
#--------------ADMIN--------------
nombreadmin=$( sed -n "$contador"p /backupsscripts/servidorbasedatos/usuarios.tx | grep Administrador | cut -d " " -f1  )
apellidoadmin=$( sed -n "$contador"p /backupsscripts/servidorbasedatos/usuarios.tx | grep Administrador | cut -d " " -f2  )
contraseniaadmin=$( sed -n "$contador"p /backupsscripts/servidorbasedatos/usuarios.tx | grep Administrador | cut -d " " -f3  )
useradd -g admin "$nombreadmin""$apellidoadmin" 
echo -e "$contraseniaadmin\n$contraseniaadmin\n" | passwd "$nombreadmin""$apellidoadmin" 
fi

let contador=$contador+1 
done
