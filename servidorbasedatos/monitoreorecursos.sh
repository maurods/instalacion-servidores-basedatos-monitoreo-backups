#!/bin/bash

while [ 0 ]
do
clear

echo -e '               '"###############################################################"

echo -e '               '"#"'                                                             '"#" 


                               horaytiempoactivo=$(uptime | cut -d "," -f1)
echo -e '               '"#"' ' FECHA Y TIEMPO DE DISPONIBILIDAD'                           '"#" 
echo -e '               '"#"' ' $horaytiempoactivo '                                          '"#" 

echo -e '               '"#"'                                                             '"#" 

echo -e '               '"#"' ' MEMORIA RAM '                                               '"#" 
                                 ramtotal=$(free -h | sed -n 2p | tr -s ' ' | cut -d " " -f2)
echo -e '               '"#"' ' Total: $ramtotal '                                               '"#" 
                                 ramlibre=$(free -h | sed -n 2p | tr -s ' ' | cut -d " " -f4)
echo -e '               '"#"' ' Libre: $ramlibre '                                               '"#" 

consumomaximonombre=$(ps aux --width 30 --sort -rss | sed -n 2p | tr -s ' ' | cut -d " " -f1)
consumomaximocant=$(ps aux --width 30 --sort -rss | sed -n 2p | tr -s ' ' | cut -d " " -f4)
consumomaximopid=$(ps aux --width 30 --sort -rss | sed -n 2p | tr -s ' ' | cut -d " " -f2)
echo -e '               '"#"' ' Maximo: $consumomaximonombre Valor: %$consumomaximocant PID: $consumomaximopid '                       '"#" 

echo -e '               '"#"'                                                             '"#"   



echo -e '               '"#"' ' MEMORIA EN DISCO '                                          '"#" 
                          discototal=$(df -h | grep "/dev/sda*" | tr -s ' ' | cut -d " " -f2) 
echo -e '               '"#"' ' Total: $discototal '                                                '"#" 

                          discolibre=$(df -h | grep "/dev/sda*" | tr -s ' ' | cut -d " " -f4) 
echo -e '               '"#"' ' Libre: $discolibre '                                               '"#" 


echo -e '               '"#"'                                                             '"#"
echo -e '               '"#"' ' CPU '                                                       '"#" 
                          cpulibre=$(top -bn1 | sed -n 3p | tr -s ' ' | cut -d " " -f8) 
echo -e '               '"#"' ' Libre: $cpulibre '                                               '"#" 

maximonombre=$(ps aux --width 30 --sort -rss | sed -n 2p | tr -s ' ' | cut -d " " -f1)
maximocant=$(ps aux --width 30 --sort -rss | sed -n 2p | tr -s ' ' | cut -d " " -f3)
maximopid=$(ps aux --width 30 --sort -rss | sed -n 2p | tr -s ' ' | cut -d " " -f2)
echo -e '               '"#"' ' Maximo: $maximonombre Valor: %$maximocant PID: $maximopid '                        '"#" 

echo -e '               '"#"'                                                             '"#" 


echo -e '               '"#"' ' USUARIOS CONECTADOS '                                       '"#" 

                         usuario=$(ps -ef | grep @pts | head -1 | tr -s ' ' | cut -d " " -f1)
                          pid=$(ps -ef | grep @pts | head -1 | tr -s ' ' | cut -d " " -f2)
echo -e '               '"#"' ' Usuario: $usuario PID: $pid '                                 '"#" 

echo -e '               '"#"'                                                             '"#" 

echo -e '               '"#"' ' CONEXIONES AL SERVIDOR '                                    '"#" 
protocolo=$(ss | grep ssh | tr -s ' ' | head -3 | cut -d " " -f1)
desde=$(ss | grep ssh | tr -s ' ' | head -3 | cut -d " " -f6)
echo -e '               '"#"' ' $desde '                   '"#" 
echo -e '               '"#"' ' Mas datos en log... '                                       '"#" 
echo -e '               '"#"'                                                             '"#" 
echo -e '               '"###############################################################"



sleep 5 

done 
