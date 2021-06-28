#!/bin/sh

echo yes | sshpass -p 'Enigma.2019' rsync --bwlimit=2000 -avhe ssh /archivosbackups/  w71a6a844jqf@23.229.218.227:/home/w71a6a844jqf/backupsinmobiliaria/archivosbackups/

echo yes | sshpass -p 'Enigma.2019' rsync --bwlimit=2000 -avhe ssh /backupsscripts/  w71a6a844jqf@23.229.218.227:/home/w71a6a844jqf/backupsinmobiliaria/backupsscripts/ 

echo yes | sshpass -p 'Enigma.2019' rsync --bwlimit=2000 -avhe ssh /home/  w71a6a844jqf@23.229.218.227:/home/w71a6a844jqf/backupsinmobiliaria/hometerminales/ 






 
