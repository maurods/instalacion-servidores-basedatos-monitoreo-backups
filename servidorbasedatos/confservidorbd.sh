#!/bin/bash
apt-get install net-tools

#CAMBIO DE NOMBRE DEL EQUIPO
echo servidorbd > /etc/hostname

#CONFIGURACION DE RED
#elimina todas las lineas menos la que contiene ...source.... que es de configuracion 

sed '/source/!d' /etc/network/interfaces > /etc/network/interfacess




mv /etc/network/interfacess /etc/network/interfaces 

#crea un archivo para guardar la configuracion del ipconfig ... IPs que tiene el servidor 
ifconfig > /ifconfig

virtualVB=$( grep enp0s /ifconfig | cut -d ":" -f1 ) 

#EL SERVIDOR ES VIRTUAL (VirtualBox)
echo >> /etc/network/interfaces
echo auto $virtualVB >> /etc/network/interfaces 
echo iface $virtualVB inet static >> /etc/network/interfaces 
echo address 192.168.1.252 >> /etc/network/interfaces  
echo network 192.168.43.1  >> /etc/network/interfaces 
echo broadcast 192.168.1.255 >> /etc/network/interfaces 
echo gateway 192.168.1.1 >> /etc/network/interfaces  

/etc/init.d/networking restart
