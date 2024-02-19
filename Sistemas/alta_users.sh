#!/bin/bash
opcion=0
COLOR_ROJO="\e[31m"
COLOR_BG_ROJO="\e[37;41m"
COLOR_VERDE="\e[32m"
COLOR_AMARILLO="\e[33m"
COLOR_AZUL="\e[34m"
COLOR_MAGENTA="\e[35m"
COLOR_CYAN="\e[36m"
COLOR_RESET="\e[0m"

while [ $opcion -ne 5 ]
do
	clear
	echo -e "\t\t\t $COLOR_BG_ROJO =================== $COLOR_RESET"
	echo -e "\t\t\t $COLOR_BG_ROJO GESTION DE USUARIOS $COLOR_RESET"
	echo -e "\t\t\t $COLOR_BG_ROJO =================== $COLOR_RESET"
	echo -e "\t\t\t 1. $COLOR_VERDE Crear $COLOR_RESET nuevo usuario"
	echo -e "\t\t\t 2. $COLOR_ROJO Borrar $COLOR_RESET usuario"
	echo -e "\t\t\t 3. $COLOR_AMARILLO Cambiar password $COLOR_RESET usuario"
	echo -e "\t\t\t 4. Añadir a un nuevo grupo un usuario existente."
	echo -e "\t\t\t 5. --SALIR--"
	echo -n -e "\t\t\t\t Opcion:_"; read opcion

	case $opcion in
		1)
			echo -n -e "\n\n\t\t\t Nombre usuario a crear:_"; read usuario
			[ -z "$usuario" ] && { echo -e "\t\t\t ... no puede estar en blanco..."; sleep 2s; continue; }

			echo -n -e "\t\t\t Password del usuario:_"; read pass
			[ -z "$pass" ] && { echo -e "\t\t\t ... no puede estar en blanco..."; sleep 2s; continue; }

			echo -n -e "\t\t\t Grupo principal del usuario:_"; read grupo
			grep -e "^$grupo:x:" /etc/group >/dev/null || { echo -e "\t\t\t...no existe el grupo, lo creamos..."; sudo groupadd $grupo; }

			echo -n -e "\t\t\t Detalles del usuario (nombre,apellidos,tlfno):_"; read comments
			sudo useradd -g $grupo -c $comments $usuario && echo -e "\t\t\t $COLOR_VERDE usuario CREADO OKS $COLOR_RESET ...";
			echo "$usuario:$pass" | sudo chpasswd
			;;

		5)
			exit 0
			;;
	esac
done
