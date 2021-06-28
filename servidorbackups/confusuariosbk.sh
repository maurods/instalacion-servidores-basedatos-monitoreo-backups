#!/bin/bash 

contador=1
lineas=$( wc -l /backupsscripts/servidorbackups/usuarios.tx | cut -d " " -f1 ) 
groupadd generico
groupadd admin
groupadd gerente
groupadd agente

useradd -m -g generico -G admin Generico
chmod -R 700 /home/Generico
chgrp -R generico /home/Generico

#recorre el archivo usuarios para agregarlos segun su nombre y funcion 
while [ $contador -le $lineas ]
do

if [ $contador -le 4 ]
then
#--------------ADMIN--------------
nombreadmin=$( sed -n "$contador"p /backupsscripts/servidorbackups/usuarios.tx | grep Administrador | cut -d " " -f1  )
apellidoadmin=$( sed -n "$contador"p /backupsscripts/servidorbackups/usuarios.tx | grep Administrador | cut -d " " -f2  )
contraseniaadmin=$( sed -n "$contador"p /backupsscripts/servidorbackups/usuarios.tx | grep Administrador | cut -d " " -f3  )
useradd -m -g admin "$nombreadmin""$apellidoadmin" 
echo -e "$contraseniaadmin\n$contraseniaadmin\n" | passwd "$nombreadmin""$apellidoadmin" 
chmod -R 700 /home/"$nombreadmin""$apellidoadmin" 
fi


if [ $contador = 5 ]
then
#------------GERENTE---------------
nombregerente=$( sed -n "$contador"p /backupsscripts/servidorbackups/usuarios.tx | grep Gerente | cut -d " " -f1  )
apellidogerente=$( sed -n "$contador"p /backupsscripts/servidorbackups/usuarios.tx | grep Gerente | cut -d " " -f2  )
contraseniagerente=$( sed -n "$contador"p /backupsscripts/servidorbackups/usuarios.tx | grep Gerente | cut -d " " -f3  )
useradd -m -g gerente -G admin "$nombregerente""$apellidogerente" 
echo -e "$contraseniagerente\n$contraseniagerente\n" | passwd "$nombregerente""$apellidogerente" 
chmod -R 740 /home/"$nombregerente""$apellidogerente"/ 
fi

if [ $contador -ge 6 ]
then
#------------AGENTE---------------
nombreagente=$( sed -n "$contador"p /backupsscripts/servidorbackups/usuarios.tx | grep Agente | cut -d " " -f1  )
apellidoagente=$( sed -n "$contador"p /backupsscripts/servidorbackups/usuarios.tx | grep Agente | cut -d " " -f2  )
contraseniaagente=$( sed -n "$contador"p /backupsscripts/servidorbackups/usuarios.tx | grep Agente | cut -d " " -f3  )
useradd -m -g agente -G admin "$nombreagente""$apellidoagente" 
echo -e "$contraseniaagente\n$contraseniaagente\n" | passwd "$nombreagente""$apellidoagente" 
chmod -R 740 /home/"$nombreagente""$apellidoagente" 
fi

let contador=$contador+1 
done
