#!/bin/sh 
systemctl list-units > listaunidades.tx 


contador=1
lineas=$( wc -l listaunidades.tx | cut -d " " -f1 ) 

#recorre el archivo para ver si hay fallas 
while [ $contador -le $lineas ]
do


error=$( sed -n "$contador"p listaunidades.tx | grep failed  )

if test ! -z "$error" 
then

echo $error >> listaunidadesfallidas.tx 

fi

let contador=$contador+1 
done

rm /backups/listaunidades.tx

















 
