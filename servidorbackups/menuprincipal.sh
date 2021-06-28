menuprincipal () {
clear
echo
echo -e '               '"###############################################################"
echo -e '               '"#"'                                                             '"#" 
echo -e '               '"#"'         '------ MENU PRINCIPAL SERVIDOR BACKUPS------ '       '"#" 
echo -e '               '"#"'                                                             '"#" 
echo -e '               '"#""\t"'   ' 1. Instalacion inicial del servidor'              '"#" 
echo -e '               '"#""\t"'   ' 2. Crear usuarios necesarios '                    '"#" 
echo -e '               '"#""\t"'   ' 3. Configuracion backups servidores'              '"#" 
echo -e '               '"#""\t"'   ' 4. Salir'                                         '"#"
echo -e '               '"#"'                                                             '"#" 
echo -e '               '"###############################################################"
read -p '                         |' opcion




case $opcion in
     1)
       bash /backupsscripts/servidorbackups/confservidorbk.sh 
       menuprincipal 
     ;;
     2)
       bash /backupsscripts/servidorbackups/confusuariosbk.sh 
       menuprincipal
     ;;
     3)
       bash /backupsscripts/servidorbackups/confbackups.sh 
       menuprincipal
     ;;
     4)
       bash /backupsscripts/menu.sh 
     ;;		
esac  
}



menuprincipal


