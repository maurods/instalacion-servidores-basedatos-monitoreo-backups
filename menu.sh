clear
echo
echo -e '               '"###############################################################"
echo -e '               '"#"'                                                             '"#" 
echo -e '               '"#""\t""\t"------ MENU PRINCIPAL ------ '                '"#" 
echo -e '               '"#"'                                                             '"#" 
echo -e '               '"#""\t"'   ' 1. Instalar servidor base datos'                  '"#" 
echo -e '               '"#""\t"'   ' 2. Instalar servidor monitoreo '                  '"#" 
echo -e '               '"#""\t"'   ' 3. Instalar servidor backups'                     '"#" 
echo -e '               '"#""\t"'   ' 4. Administracion cuentas de usuarios '           '"#" 
echo -e '               '"#""\t"'   ' 5. Monitoreo servidor local'                      '"#" 
echo -e '               '"#""\t"'   ' 6. Salir'                                         '"#"
echo -e '               '"#"'                                                             '"#" 
echo -e '               '"###############################################################"
read -p '                         |' opcion




case $opcion in
     1)
       bash /backupsscripts/servidorbasedatos/menuprincipal.sh 
       
     ;;
     2)
       bash /backupsscripts/servidormonitoreo/menuprincipal.sh 
     ;;
     3)
       bash /backupsscripts/servidorbackups/menuprincipal.sh 
     ;;
     4)
       bash /backupsscripts/abmusuariosygrupos.sh 
     ;;	
     5)
       bash /backupsscripts/monitoreorecursos.sh 
     ;;
     6)
       exit
     ;; 	
esac  





