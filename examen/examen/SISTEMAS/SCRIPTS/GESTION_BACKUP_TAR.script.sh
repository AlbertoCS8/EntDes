#!/bin/bash

#FINISHED

COLOR_RESET="\e[0m"
COLOR_ROJO="\e[31m"
COLOR_AMARILLO="\e[33m"
COLOR_VERDE="\e[32m"

#-------------------------------------------------------------------------------------------------------------------------#
#---------------------------------------------------FUNCIONES-DE-BACKUPS--------------------------------------------------#
#-------------------------------------------------------------------------------------------------------------------------#
function backUpTotal() {
	getDir || return 1
	tar -c -v -z -f "$DIR_DESTINO"/backup_total_"$DIR_RE"_"$BU_DATE".tar.gz \
		-g /home/manuel/Documentos/prueba/ficheroFechas_"$DIR_RE" \
		"$DIR_ORIGEN" #con ese comando vamos a crear un backup total y lo escribimos en el fichero de fechas si no existe se creara automaticamente
	return 0
}

function backUpIncremental() {
	local CONTADOR=1
	local ERROR=1
	getDir || return 1

	while [ $ERROR -ne 0 ]; do
		FICHERO="${DIR_DESTINO}/backup_incremental_${DIR_RE}_${CONTADOR}.tar.gz" #creamos una variable que va a almacenar el nombre completo
																				#del fichero backup incremental
		[[ -e $"$FICHERO" ]] && CONTADOR=$((CONTADOR + 1)) || ERROR=0 #si el fichero existe se sumara el contador hasta que el fichero ya no exista
																	#si no existe el fichero se establecera error como 0 y se saldra del bucle
	done

	tar -c -v -z -f "$DIR_DESTINO"/backup_incremental_"$DIR_RE"_"$CONTADOR".tar.gz \
		-g /home/manuel/Documentos/prueba/ficheroFechas_"$DIR_RE" \
		"$DIR_ORIGEN" #ahora vamos a crear el backup incremental con todas las variables y el contador teniendo en cuenta que el fichero no existe
	return 0
}

function setVariables() { # vamos a establecer las variables van a indicar la fecha o la ruta del directorio para los backups
	DIR_RE=$(echo "$DIR_ORIGEN" | tr "/" "_")
	BU_DATE=$(date +%d%m%Y-%H:%M)
	return 0
}

#-------------------------------------------------------------------------------------------------------------------------#
#-------------------------------------------------FUNCIONES-DE-COMPROBACION-----------------------------------------------#
#-------------------------------------------------------------------------------------------------------------------------#
function getDir() { #con esta funcion pediremos el directorio origen y destino
	echo -n -e "\n\n\n\t\t directorio del que quieres hacer el backup total..."
	read DIR_ORIGEN
	echo -n -e "\t\t directorio de destino donde quieres GUARDAR el backup total..."
	read DIR_DESTINO

	[ -z "$DIR_ORIGEN" ] || [ -z "$DIR_DESTINO" ] && { #comprobamos si alguna de las variables esta vacia
		echo -e "${COLOR_ROJO}alguna de las variables se encuentra vacia${COLOR_RESET}"
		sleep 2
		return 1
	}
	setVariables || return 1
	return 0
}

#-------------------------------------------------------------------------------#
#----------------------------- main --------------------------------------------#
#-------------------------------------------------------------------------------#
OPCION=0
while [ "$OPCION" -ne 3 ]; do
	clear
	echo -e "\t\t $COLOR_VERDE BACKUPS CON TAR $COLOR_RESET"
	echo -e "\t\t $COLOR_VERDE --------------- $COLOR_RESET"
	echo -e "\t\t 1. backup total"
	echo -e "\t\t 2. backup incremental"
	echo -e "\t\t 3. == SALIR =="
	echo -n -e "\t\t\t $COLOR_AMARILLO opcion: $COLOR_RESET"
	read OPCION

	case $OPCION in
	1) backUpTotal ;;
	2) backUpIncremental ;;
	3) ;;
	*) echo "opcion incorrecta...." ;;
	esac
done
