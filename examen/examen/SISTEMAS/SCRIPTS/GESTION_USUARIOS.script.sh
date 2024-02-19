#!/bin/bash

#FINISHED

COLOR_ROJO="\e[31m"
COLOR_BG_ROJO="\e[37;41m"
COLOR_VERDE="\e[32m"
COLOR_AMARILLO="\e[33m"
COLOR_AZUL="\e[34m"
COLOR_MAGENTA="\e[35m"
COLOR_CYAN="\e[36m"
COLOR_RESET="\e[0m"

#-------------------------------------------------------------------------------------------------------------------------#
#---------------------------------------------------FUNCIONES-DE-USUARIOS-------------------------------------------------#
#-------------------------------------------------------------------------------------------------------------------------#
function makeUser() {
	getUser || return 1
	getPasswd || return 1
	getGroup || return 1

	echo -n -e "\t\t\t ${COLOR_AMARILLO}Detalles del usuario (nombre,apellidos,tlfno):_$COLOR_RESET"
	read comments
	sudo useradd -g "$grupo" -c "$comments" "$usuario" >/dev/null 2>/dev/null && echo -e "\t\t\t $COLOR_VERDE usuario CREADO OKS $COLOR_RESET ..."
	echo "$usuario:$pass" | sudo chpasswd 2>/dev/null || {
		echo -e "${COLOR_ROJO}error cambiando la contraseña$COLOR_RESET"
		return 1
	}
}

function delUser() {
	CMD="sudo userdel"
	getUser || return 1
	checkValidUser || return 1
	echo -n -e "\t\t\t ${COLOR_AMARILLO}Quieres eliminar el directorio personal [y/n]:_${COLOR_RESET}"
	read OP
	case $OP in
	"y") CMD+=" -r" ;;
	"n") ;;
	*)
		echo "${COLOR_ROJO}opcion incorrecta${COLOR_RESET}"
		return 1
		;;
	esac
	CMD+=" $usuario"
	eval "$CMD" 2>/dev/null >/dev/null || {
		echo "${COLOR_ROJO}no se ha podido borrar el usuario$COLOR_RESET"
		return 1
	}
	echo "${COLOR_VERDE}se ha borrado el usuario ${COLOR_CYAN}${usuario}$COLOR_RESET"
}

function changePasswd() {
	getUser || return 1
	checkValidUser || return 1
	getPasswd || return 1
	echo "$usuario:$pass" | sudo chpasswd 2>/dev/null || {
		echo "${COLOR_ROJO}no se ha podido cambiar la contraseña$COLOR_RESET"
		return 1
	}
	echo -e "${COLOR_VERDE}se ha cambiado la contraseña de ${COLOR_CYAN}${usuario}$COLOR_RESET"
}

function addGroup() {
	getUser || return 1
	checkValidUser || return 1
	getGroup || return 1
	sudo usermod -aG "$grupo" "$usuario" || {
		echo "${COLOR_ROJO}no se ha añadir el grupo$COLOR_RESET"
		return 1
	}
	echo -e "${COLOR_VERDE}se ha añadido ${COLOR_CYAN}$usuario al grupo ${COLOR_CYAN}${grupo}$COLOR_RESET"
}

#-------------------------------------------------------------------------------------------------------------------------#
#-------------------------------------------------FUNCIONES-DE-COMPROBACION-----------------------------------------------#
#-------------------------------------------------------------------------------------------------------------------------#
function getUser() { #funcion para obtener el nombre del usuario
	echo -n -e "\n\n\t\t\t ${COLOR_AMARILLO}Nombre usuario:_$COLOR_RESET"
	read usuario
	[ -z "$usuario" ] && {
		echo -e "\t\t\t ... ${COLOR_ROJO}no puede estar en blanco...$COLOR_RESET"
		sleep 2s
		return 1
	}
	return 0
}

function getPasswd() { #funcion para obtener la contraseña del usuario
	echo -n -e "\t\t\t ${COLOR_AMARILLO}Password del usuario:_$COLOR_RESET"
	read pass
	[ -z "$pass" ] && {
		echo -e "\t\t\t ${COLOR_ROJO}... no puede estar en blanco...$COLOR_RESET"
		sleep 2s
		return 1
	}
	return 0
}

function getGroup() { #funcion para obtener el grupo
	echo -n -e "\t\t\t ${COLOR_AMARILLO}Grupo del usuario:_${COLOR_RESET}"
	read grupo
	[ -z "$grupo" ] && {
		echo -e "${COLOR_ROJO}el grupo no puede estar vacio$COLOR_RESET"
		return 1
	}
	grep -e "^$grupo:x:" /etc/group >/dev/null || {
		echo -e "\t\t\t${COLOR_ROJO}...no existe el grupo, lo creamos...$COLOR_RESET"
		sudo groupadd "$grupo"
	}
	return 0
}

function checkValidUser() { #funcion para comprobar que el usuario existe
	grep -e "^$usuario" /etc/passwd >/dev/null || {
		echo -e "${COLOR_ROJO}no existe el usuario${COLOR_RESET}"
		return 1
	}
	return 0
}

#-------------------------------------------------------------------------------#
#----------------------------- main --------------------------------------------#
#-------------------------------------------------------------------------------#
OPCION=0
while [ "$OPCION" -ne 5 ]; do
	clear
	echo -e "\t\t\t $COLOR_BG_ROJO =================== $COLOR_RESET"
	echo -e "\t\t\t $COLOR_BG_ROJO GESTION DE USUARIOS $COLOR_RESET"
	echo -e "\t\t\t $COLOR_BG_ROJO =================== $COLOR_RESET"
	echo -e "\t\t\t 1. $COLOR_VERDE Crear nuevo usuario $COLOR_RESET"
	echo -e "\t\t\t 2. $COLOR_AZUL Borrar usuario $COLOR_RESET"
	echo -e "\t\t\t 3. $COLOR_AMARILLO Cambiar password usuario $COLOR_RESET"
	echo -e "\t\t\t 4. $COLOR_MAGENTA Añadir a un nuevo grupo a un usuario existente $COLOR_RESET"
	echo -e "\t\t\t 5. --SALIR--"
	echo -n -e "\t\t\t\t ${COLOR_AMARILLO}Opcion:_$COLOR_RESET"
	read OPCION

	case $OPCION in
	1) makeUser ;;
	2) delUser ;;
	3) changePasswd ;;
	4) addGroup ;;
	5) ;;
	esac
	sleep 3
	clear
done
