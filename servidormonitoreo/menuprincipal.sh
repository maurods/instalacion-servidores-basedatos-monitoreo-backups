menuprincipal () { 
clear
echo
echo -e '               '"###############################################################"
echo -e '               '"#"'                                                             '"#" 
echo -e '               '"#"'         '------ MENU PRINCIPAL SERVIDOR ZABBIX------ '        '"#" 
echo -e '               '"#"'                                                             '"#" 
echo -e '               '"#""\t"'   ' 1. Instalacion inicial del servidor'              '"#" 
echo -e '               '"#""\t"'   ' 2. Crear usuarios necesarios '                    '"#" 
echo -e '               '"#""\t"'   ' 3. Instalacion servidor Zabbix'                   '"#" 
echo -e '               '"#""\t"'   ' 4. Configuracion backups servidores '             '"#" 
echo -e '               '"#"'                                                             '"#" 
echo -e '               '"#""\t"'   ' 5. Restaurar BD desde archivos servidor bk '      '"#" 
echo -e '               '"#""\t"'   ' 6. Salir'                                         '"#"
echo -e '               '"#"'                                                             '"#" 
echo -e '               '"###############################################################"
read -p '                         |' opcion


case $opcion in
     1)
       bash /backupsscripts/servidormonitoreo/confservidorMonitoreo.sh 
       menuprincipal 
     ;;
     2)
       bash /backupsscripts/servidormonitoreo/confusuario.sh 
       menuprincipal
     ;;
     3)
       bash /backupsscripts/servidormonitoreo/installserverZabbix.sh
       bash /backupsscripts/servidormonitoreo/importarbasedatos.sh 
       menuprincipal
     ;;
     4)
       bash /backupsscripts/servidormonitoreo/confbackup.sh 
       menuprincipal
     ;;
     5)

clear
echo
echo -e '               '"###############################################################"
echo -e '               '"#"'                                                             '"#" 
echo -e '               '"#""\t"'   '--- IMPORTAR DATOS EN HISTORICO --- '              '"#" 
echo -e '               '"#"'           'Ingrese año del archivo '                          '"#" 
echo -e '               '"#"'                                                             '"#" 
echo -e '               '"###############################################################"
read -p '                         |' anio
 

clear
echo
echo -e '               '"###############################################################"
echo -e '               '"#"'                                                             '"#" 
echo -e '               '"#""\t"'   '--- IMPORTAR DATOS EN HISTORICO --- '              '"#" 
echo -e '               '"#"'           'Ingrese mes del archivo '                      '"#" 
echo -e '               '"#"'                                                             '"#" 
echo -e '               '"###############################################################"
read -p '                         |' mes 


ceromes=$mes
case $mes in
     1)
       ceromes=01 
     ;;
     2)
       ceromes=02 
     ;;
     3)
       ceromes=03 
     ;;		
     4)
       ceromes=04
     ;; 
     5)
       ceromes=05
     ;;
     6)
       ceromes=06
     ;;
     7)
       ceromes=07
     ;;
     8)
       ceromes=08
     ;;
     9)
       ceromes=09
     ;;
      
esac  

 
bash /backupsscripts/servidormonitoreo/importarsqlservbk.sh "$anio"-"$ceromes".*  
       menuprincipal  

     ;;
     6)
      bash /backupsscripts/menu.sh 

     ;;	
esac  
}

menuprincipal





















