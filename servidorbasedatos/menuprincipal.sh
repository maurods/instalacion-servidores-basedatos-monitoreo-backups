menuprincipal () {
clear
echo
echo -e '               '"###############################################################"
echo -e '               '"#"'                                                             '"#" 
echo -e '               '"#""\t"------ MENU PRINCIPAL SERVIDOR BASEDATOS ------ '     '"#" 
echo -e '               '"#"'                                                             '"#" 
echo -e '               '"#""\t"'   ' 1. Instalacion inicial del servidor'              '"#" 
echo -e '               '"#""\t"'   ' 2. Administracion motor base datos'               '"#" 
echo -e '               '"#""\t"'   ' 3. Salir'                                         '"#"
echo -e '               '"#"'                                                             '"#" 
echo -e '               '"###############################################################"
read -p '                         |' opcion




case $opcion in
     1)
       menuinstalacioninicial 
     ;;
     2)
       menuadministracionmotorbasedatos 
     ;;
     3)
       bash /backupsscripts/menu.sh 
     ;;		
esac  
}





menuinstalacioninicial () {
clear

echo
echo -e '               '"###############################################################"
echo -e '               '"#"'                                                             '"#" 
echo -e '               '"#""\t"'   '--- INSTALACION INICIAL DEL SERVIDOR --- '         '"#" 
echo -e '               '"#"'                                                             '"#" 
echo -e '               '"#""\t"'   ' 1. Configurar nombre equipo y red '               '"#" 
echo -e '               '"#""\t"'   ' 2. Configurar usuarios y grupos '                 '"#" 
echo -e '               '"#""\t"'   ' 3. Instalar MySQL en el servidor '                '"#" 
echo -e '               '"#""\t"'   ' 4. Importar datos a MySQL '                       '"#" 
echo -e '               '"#""\t"'   ' 5. Configurar backups del servidor '              '"#" 
echo -e '               '"#""\t"'   ' 6. Volver al menu principal '                     '"#" 
echo -e '               '"#"'                                                             '"#" 
echo -e '               '"###############################################################"

read -p '                         |' opcion


case $opcion in
     1)
        bash /backupsscripts/servidorbasedatos/confservidorbd.sh  
        menuinstalacioninicial 
     ;;
     2)
        bash /backupsscripts/servidorbasedatos/confusuariosbd.sh
        menuinstalacioninicial
     ;;
     3)
        bash /backupsscripts/servidorbasedatos/installserverMysql.sh
        menuinstalacioninicial
     ;;
     4)
        bash /backupsscripts/servidorbasedatos/importarsql.sh
        menuinstalacioninicial 
     ;;
     5)
        bash /backupsscripts/servidorbasedatos/confbackups.sh 
        menuinstalacioninicial
     ;;
     6)
        menuprincipal 
     ;; 
esac  
}



#-----------------------------------------------------------------------------------------------







menuadministracionmotorbasedatos () {
clear
echo
echo -e '               '"###############################################################"
echo -e '               '"#"'                                                             '"#" 
echo -e '               '"#""\t"'   '--- ADMINISTRAION MOTOR BASE DATOS --- '           '"#" 
echo -e '               '"#"'                                                             '"#" 
echo -e '               '"#"'     ' 1. Start servicio mysql '                               '"#" 
echo -e '               '"#"'     ' 2. Stop servicio mysql '                                '"#" 
echo -e '               '"#"'     ' 3. Importar BD mas reciente desde servidor local '      '"#" 
echo -e '               '"#"'     ' 4. Importar BD desde historico servidor backups '       '"#" 
echo -e '               '"#"'     ' 5. Importar BD desde historico servidor nube '          '"#" 
echo -e '               '"#"'                                                             '"#" 
echo -e '               '"#"'     ' 6. Importar datos a  BD de log binario servidor bk '     '"#" 
echo -e '               '"#"'     ' 7. Importar datos a  BD de log binario servidor nube '   '"#" 
echo -e '               '"#"'     ' 8. Volver a menu principal'                             '"#" 
echo -e '               '"#"'                                                             '"#" 
echo -e '               '"###############################################################"
read -p '                         |' opcion

case $opcion in
     1)
       service mysql start  
       if [ $(systemctl | grep mysql | grep running | wc - l) = 0 ]
       then
           echo Error, no se pudo iniciar MySQL. Verificar LOG
           read p 
       fi 
       menuprincipal 
             
     ;;
     2)
       service mysql stop
       menuprincipal  
     ;;
     3)
       bash /backupsscripts/servidorbasedatos/importarsql.sh 

       menuadministracionmotorbasedatos 
     ;;
     4)


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
echo -e '               '"#"'           'Ingrese mes del archivo '                          '"#" 
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

 
bash /backupsscripts/servidorbasedatos/importarsqlservbk.sh "$anio"-"$ceromes".sql  
       menuadministracionmotorbasedatos  

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
echo -e '               '"#"'           'Ingrese mes del archivo incluyendo el cero'        '"#" 
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

 
bash /backupsscripts/servidorbasedatos/importarsqlservnube.sh "$anio"-"$ceromes".sql  
       menuadministracionmotorbasedatos  
  
     ;;
     6)  


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
echo -e '               '"#"'           'Ingrese mes del archivo incluyendo el cero'        '"#" 
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

clear
echo
echo -e '               '"###############################################################"
echo -e '               '"#"'                                                             '"#" 
echo -e '               '"#""\t"'   '--- IMPORTAR DATOS EN HISTORICO --- '              '"#" 
echo -e '               '"#"'                'Ingrese dia del archivo '                     '"#" 
echo -e '               '"#"'                                                             '"#" 
echo -e '               '"###############################################################"
read -p '                         |' dia 


ceroi=$dia 

case $i in
     1)
       ceroi=01 
     ;;
     2)
       ceroi=02 
     ;;
     3)
       ceroi=03 
     ;;		
     4)
       ceroi=04
     ;; 
     5)
       ceroi=05
     ;;
     6)
       ceroi=06
     ;;
     7)
       ceroi=07
     ;;
     8)
       ceroi=08
     ;;
     9)
       ceroi=09
     ;;
      
esac  


bash /backupsscripts/servidorbasedatos/recibirbinlogsservbk.sh

bash /backupsscripts/servidorbasedatos/bkmysqlbinlog.sh  



clear
echo
echo -e '               '"###############################################################"
echo -e '               '"#"'                                                             '"#" 
echo -e '               '"#""\t"'   '--- IMPORTAR DATOS EN HISTORICO --- '              '"#" 
echo -e '               '"#"'        'Ingrese primer numero del archivo que elija'          '"#" 
echo -e '               '"#"'                                                             '"#" 

ls /archivosbackups/binlogs/$anio/$ceromes/$ceroi/ | column | sed 's/^/               # /g' 

echo -e '               '"###############################################################"
read -p '                         |' arch 

archivo=$(ls /archivosbackups/binlogs/$anio/$ceromes/$ceroi/$arch* | cut -d "/" -f7 | cut -d "-" -f1) 
cantidaddias=$(ls /archivosbackups/binlogs/$anio/$ceromes/ | wc -l)



 
bash /backupsscripts/servidorbasedatos/importarsqlservbk.sh "$anio"-"$ceromes".sql  




#FOR UTILIZADO PARA ENTRAR EN CADA DIRECTORIO DE CADA DIA 
for ((i=1; i<=$cantidaddias; i++))
do


ceroi=$i 

case $i in
     1)
       ceroi=01 
     ;;
     2)
       ceroi=02 
     ;;
     3)
       ceroi=03 
     ;;		
     4)
       ceroi=04
     ;; 
     5)
       ceroi=05
     ;;
     6)
       ceroi=06
     ;;
     7)
       ceroi=07
     ;;
     8)
       ceroi=08
     ;;
     9)
       ceroi=09
     ;;
      
esac  


cantidadarchivospordia=$(ls /archivosbackups/binlogs/$anio/$ceromes/$ceroi/ | wc -l) 


#SI EL DIA ES IGUAL AL DIA SELECCIONADO OTRAS VALIDACIONES PARA EJECUTAR LOGS HASTA EL ARCHIVO SELECCIONADO 
if [ $i = $dia ]
then


    for ((j=1; j<=$arch; j++))
        do




ls -l  /archivosbackups/binlogs/$anio/$ceromes/$ceroi/$j-*    


mysqlbinlog  /archivosbackups/binlogs/$anio/$ceromes/$ceroi/$j-* | mysql -uroot -pEnigma.2019 enigma   



        done



let i=$cantidaddias+1

else




#EJECUTA TODOS LOS LOGS ENCONTRADOS EN EL DIRECOTIO DE CADA DIA
 
    for ((j=1; j<=$cantidadarchivospordia; j++))
        do


ls -l /archivosbackups/binlogs/$anio/$ceromes/$ceroi/$j-*   

mysqlbinlog  /archivosbackups/binlogs/$anio/$ceromes/$ceroi/$j-* | mysql -uroot -pEnigma.2019 enigma   


        done

fi
done



menuadministracionmotorbasedatos




    



     ;;
     7)
        echo "Log binario servidor nube"
        read opes
     ;;
     8)
        menuprincipal
     ;;
esac  
}


menuprincipal










