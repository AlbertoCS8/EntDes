#!/bin/bash
opcion=0
while [ $opcion -ne 7 ]
do 
	clear
	echo -e "\n\t\t\t GESTION CONTAINERS DOCKER"
	echo -e "\t\t\t =============================="
	echo -e "\t\t\t 1º LISTAR CONTENEDORES"
	echo -e "\t\t\t 2º PARAR CONTENDEOR"
	echo -e "\t\t\t 3º ARRANCAR CONTENEDOR"
	echo -e "\t\t\t 4º BORRAR CONTENEDOR"
	echo -e "\t\t\t 5º EJECUTAR COMANDO"
	echo -e "\t\t\t 6º CREAR CONTENEDOR"
	echo -e "\t\t\t 7º    ---SALIR---"
	read -n 1 -p "Dime que opcion necesitas" opcion
	
	case $opcion in
		1) echo "Cuales quieres que liste?" 
		   echo -e "\n inactive[i]"
		   echo -e "\n running[r]"
		   read -n 1 -p "i/r" lista
		   if [ $lista == i ]
		   	then
		   		sudo docker container ps
		   	fi
		   if [ $lista == r ]
		   	then
		   		sudo docker container ps -a
		   	fi
		   ;;
		   
		2) echo "Que contenedor quieres que te pare?" 
			sudo docker container ps
			read -p "Dime el nombre del contenedor: " contenedor
			sudo docker stop $contenedor && echo "se ha realizado correctamente" || echo "nombre inválido/no existe el contenedor con el nombre que has introducido"
			read -n 1 -p "debes introducir una tecla para continuar"
		;;
		3) echo "Estos son los contenedores:" ;;
		4) echo "Estos son los contenedores:" ;;
		5) echo "Estos son los contenedores:" ;;
		6) echo "Estos son los contenedores:" ;;
		7) exit 0 ;;
	esac
	sleep 5s
done
	
