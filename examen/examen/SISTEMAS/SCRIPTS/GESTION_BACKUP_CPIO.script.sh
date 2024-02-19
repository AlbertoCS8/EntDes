#!/bin/bash
COLOR_RESET="\e[0m"
COLOR_AMARILLO="\e[33m"
COLOR_VERDE="\e[32m"

#-------------------------------------------------------------------------------------------------------------------------#
#---------------------------------------------------FUNCIONES-DE-BACKUPS--------------------------------------------------#
#-------------------------------------------------------------------------------------------------------------------------#
function backUpTotal() {
	getOriDes || return 1
	setVariables || return 1
	sudo -S find "$DIR_ORIGEN" \( -type d -o -type f \) -user "$USERNAME" | cpio -o -v -B > "${DIR_DESTINO}"/backup_total_"${DR_RE}"_"${DR_DATE}".cpio
}

function backUpIncremental() {
	getOriDes || return 1
	setVariables || return 1
	FL_COMPARE=$(ls "${DIR_DESTINO}"/backup_total_"${DR_RE}"*.cpio)
	find "$DIR_ORIGEN" \( -type d -o -type f \) -user "$USERNAME" -newer "$FL_COMPARE" | cpio -o -v -B > "${DIR_DESTINO}"/backup_incremental__"${DR_RE}"_"${DR_DATE}".cpio
}

function setVariables() {
	DR_RE=$(echo "$DIR_ORIGEN" | tr "/" "_")
	DR_DATE=$(date +%d%m%Y-%H:%M)
	return 0
}

#-------------------------------------------------------------------------------------------------------------------------#
#-------------------------------------------------FUNCIONES-DE-COMPROBACION-----------------------------------------------#
#-------------------------------------------------------------------------------------------------------------------------#
function getOriDes() {
	echo -n -e "\n\n\n\t\t directorio del que quieres hacer el backup total..."; read DIR_ORIGEN
	echo -n -e "\t\t directorio de destino donde quieres GUARDAR el backup total..."; read DIR_DESTINO
	[ -z "$DIR_ORIGEN" ] || [ -z "$DIR_DESTINO" ] && { echo -e "${COLOR_VERDE}alguna de las variables estan vacias vuelva a intentarlo${COLOR_RESET}"; sleep 2; return 1; }
	return 0
}


#-------------------------------------------------------------------------------#
#----------------------------- main --------------------------------------------#
#-------------------------------------------------------------------------------#
OPCION=0
while [ "$OPCION" -ne 3 ]; do
	clear
	echo -e "\t\t $COLOR_VERDE BACKUPS CON CPIO $COLOR_RESET"
	echo -e "\t\t $COLOR_VERDE ---------------- $COLOR_RESET"
	echo -e "\t\t 1. backup total"
	echo -e "\t\t 2. backup incremental"
	echo -e "\t\t 3. == SALIR =="
	echo -n -e "\t\t\t $COLOR_AMARILLO opcion: $COLOR_RESET"; read OPCION

	case $OPCION in
		1) backUpTotal ;;
		2) backUpIncremental ;;
		3) ;;
		*) echo "opcion incorrecta...." ;;
	esac
done
