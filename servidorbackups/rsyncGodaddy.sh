#!/bin/sh

echo yes | sshpass -p 'Enigma.2019' rsync --bwlimit=2000 -avhe ssh /archivosbackups/  usuario@10.10.10.10:/home/w71a6a844jqf/backupsinmobiliaria/archivosbackups/

echo yes | sshpass -p 'Enigma.2019' rsync --bwlimit=2000 -avhe ssh /backupsscripts/  usuario@10.10.10.10:/home/w71a6a844jqf/backupsinmobiliaria/backupsscripts/ 

echo yes | sshpass -p 'Enigma.2019' rsync --bwlimit=2000 -avhe ssh /home/  usuario@10.10.10.10:/home/w71a6a844jqf/backupsinmobiliaria/hometerminales/ 






 
