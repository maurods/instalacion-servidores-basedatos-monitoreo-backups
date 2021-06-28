#!/bin/bash

crearusuario () {
useradd -m -g $1 $2  
} 

listargrupos () {
echo --------------------------------------------------------------------------------------------
cat /etc/group | cut -d ":" -f1 | column 
echo --------------------------------------------------------------------------------------------
}
listarusuarios () {
echo --------------------------------------------------------------------------------------------
cat /etc/shadow | cut -d ":" -f1 | column 
echo --------------------------------------------------------------------------------------------
} 

menu () {
clear
echo
echo -e '               '"###############################################################"
echo -e '               '"#"'                                                             '"#" 
echo -e '               '"#""\t""\t"------ MENU ADMINISTRACION USUARIOS ------ '  '"#" 
echo -e '               '"#"'                                                             '"#" 
echo -e '               '"#""\t"'   ' 1. Crear altas de usuarios o grupos'              '"#" 
echo -e '               '"#""\t"'   ' 2. Crear bajas de usuarios o grupos '             '"#" 
echo -e '               '"#""\t"'   ' 3. Modificacion de usuarios o grupos'             '"#" 
echo -e '               '"#""\t"'   ' 4. Volver al menu principal '                     '"#" 
echo -e '               '"#"'                                                             '"#" 
echo -e '               '"###############################################################"

read -p '                         |' op

}


salir=false
while [ $salir = false ]
do

menu



case $op in
   1) clear 

echo
echo -e '               '"###############################################################"
echo -e '               '"#"'                                                             '"#" 
echo -e '               '"#""\t""\t"------ MENU ADMINISTRACION USUARIOS ------ '  '"#" 
echo -e '               '"#"'                                                             '"#" 
echo -e '               '"#""\t"'   ' 1. Alta de grupo'                                 '"#" 
echo -e '               '"#""\t"'   ' 2. Alta de usuario '                              '"#" 
echo -e '               '"#""\t"'   ' 3. Volver '                                       '"#" 
echo -e '               '"#"'                                                             '"#" 
echo -e '               '"###############################################################"

read -p '                         |' alta 



                      
 
                          #------ALTA DE GRUPOS------------ 
     if [ $alta -eq 1 ] 
         then
         clear
         listargrupos
         echo Ingrese nombre grupo a crear 
         read grupo 
      
          while [ $(grep -w $grupo /etc/group | wc -l) -eq 1 ]           
                  do 
                   clear
                   listargrupos
                   echo Ya existe ese grupo 
                  read grupo
                  done 
                 
          groupadd $grupo

      fi



                        #-------ALTA DE USUARIOS----------
      if [ $alta -eq 2 ]
         then
         clear
         listarusuarios 
         echo Ingrese nombre usuario para agregar 
         read usuario 
          
            while [ $(grep -w $usuario /etc/group | wc -l) -eq 1 ]           
                  do 
                   clear 
                   listarusuarios 
                   echo Ya existe el usuario 
                   read usuario 
                  done 
   
            clear 
            listargrupos
            echo Ingrese nombre grupo a asignar al usuario 
            read grupousuario 
            while [ $(grep -w $grupousuario /etc/group | wc -l) -eq 0 ]           
                  do 
                   listargrupos 
                   echo Ingresar un grupo valido 
                   read grupousuario 
                  done 


                   crearusuario $grupousuario $usuario            


 
      fi
 
      ;;




    2) clear 
echo 
echo -e '               '"###############################################################"
echo -e '               '"#"'                                                             '"#" 
echo -e '               '"#""\t""\t"------ MENU ADMINISTRACION USUARIOS ------ '  '"#" 
echo -e '               '"#"'                                                             '"#" 
echo -e '               '"#""\t"'   ' 1. Baja de grupo'                                 '"#" 
echo -e '               '"#""\t"'   ' 2. Baja de usuario '                              '"#" 
echo -e '               '"#""\t"'   ' 3. Volver '                                       '"#" 
echo -e '               '"#"'                                                             '"#" 
echo -e '               '"###############################################################"

read -p '                         |' baja 




     if [ $baja -eq 1 ] 
         then
         clear
         listargrupos
         echo Ingrese nombre grupo a eliminar 
         read eliminargrupo
         
             while [ $(grep -w $eliminargrupo /etc/group | wc -l) -eq 0 ]           
                  do 
                   clear
             
                   listargrupos
                   echo Ingrese un grupo valido para eliminar 
                   read eliminargrupo 
                  done 
        	groupdel $eliminargrupo
                read parar 
      fi	  
	 

     if [ $baja -eq 2 ] 
         then
         clear 
         listarusuarios	
	 echo Digitar nombre usuario a eliminar 
         read eliminar
            while [ $(grep -w $eliminar /etc/shadow | wc -l) -eq 0 ]           
               do 
                   clear 
                   listarusuarios 
                   echo Ingrese un usuario valido para eliminar  
                   read eliminar 
 
                  if [ $eliminar -eq 1 ]
                      then
                      menu
                      fi 

                done
 
       echo Desea respaldar los datos ?            
       echo 1-Si
       echo 2-No
       read res
            if [ $res -eq 1 ]
             then 
             
             echo Desea comprimir los datos ?
             echo 1-Si
             echo 2-No
             read comp 
             if [ $comp -eq 2 ]   
             then 
              tar -cvf "$eliminar".tar /home/$eliminar          
             userdel -r $eliminar 
             
             else
             tar -cvzf "$eliminar".tar.gz /home/$eliminar 
              userdel -r $eliminar 
             fi   
             

 
             fi   
            if [ $res -eq 2 ]
             then
             userdel -r $eliminar
             fi    
	
	
         fi
	 
	 
     
 
      ;;
    3) clear 
echo 
echo -e '          '"###############################################################"
echo -e '          '"#"'                                                             '"#" 
echo -e '          '"#""\t""\t"- MODFICACION DE USUARIOS O GRUPOS - '           '"#" 
echo -e '          '"#"'                                                             '"#" 
echo -e '          '"#""\t"'         ' 1. Modificar grupo'                            '"#" 
echo -e '          '"#""\t"'         ' 2. Modificar usuario'                          '"#" 
echo -e '          '"#""\t"'         ' 3. Volver '                                    '"#" 
echo -e '          '"#"'                                                             '"#" 
echo -e '          '"###############################################################"
read -p '                         |' mod 

      if [ $mod -eq 1 ]
          then
          echo se modifica grupo
          read a 
       fi

       
 
       if [ $mod -eq 2 ]
         then

       echo Ingrese opcion 
       echo 1-Desea modificar nombre de usuario
       echo 2-Desea modificar grupo del usuario  
       read nomgr  

       if [ $nomgr -eq 1 ]
          then
         echo Ingrese nombre de usuario
         read usuariomod
            while [ $(grep -w $usuariomod /etc/shadow | wc -l) -eq 0 ]           
               do 
                   clear 
                   listarusuarios 
                   echo Ingrese un usuario valido para eliminar  
                   read usuariomod 
               done
                  if [ $(grep -w $usuariomod /etc/shadow | wc -l) -eq 1 ]
                      then
                      echo Ingrese nuevo nombre
                      read nuevonombre
                      usermod -l $nuevonombre $usuariomod  
                      usermod -d /home/"$nuevonombre" -m $usuariomod 
                  fi
            fi  
         if [ $nomgr -eq 2 ]
            then
             echo Ingrese nombre usuario
               read user
            while [ $(grep -w $user /etc/shadow | wc -l) -eq 0 ]           
               do 
                   clear 
                   listarusuarios 
                   echo Ingrese un usuario valido para eliminar  
                   read user 
               done
           
             if [ $(grep -w $user /etc/shadow | wc -l) -eq 1 ]
               then
                echo Ingrese nuevo grupo a asignar
                read grupnuevo
                 
         
             while [ $(grep -w $grupnuevo /etc/group | wc -l) -eq 0 ]           
                  do 
                   clear
             
                   listargrupos
                   echo Ingrese un grupo valido para asignar 
                   read grupnuevo 
                   done
                  if [ $(grep -w $grupnuevo /etc/group | wc -l) -wq 1 ]
                  then
                   usermod -g $grupnuevo $user
                   chown "$user":"$grupnuevo" /home/"$user"                          



 
                 fi 





            
               fi                  



            fi
         




 
         fi     




    ;;
    4) 
     clear  
     let salir=true
     bash /backupsscripts/menuprincipal.sh
    ;;    

esac
done 







