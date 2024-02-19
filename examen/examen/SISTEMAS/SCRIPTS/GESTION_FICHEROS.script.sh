#!/bin/bash

#FINISHED

function copyFiles() {
	getDir || return 1

	read -p "Directorio de destino..........." DESTINO
	[ -z "$DESTINO" ] && {
		echo "las variables estan vacias"
		return 1
	}

	cp "$ORIGEN"/"$FICHEROS" "$DESTINO" && echo "ficheros copiados OK..." || echo "fallo al copiar ficheros" #copiamos los ficheros en el destino
	return 0
}

function renameFile() {
	getDir || return 1

	read -p "Introduce nuevo nombre..............................." NUEVO_NOMBRE
	[ -z "$NUEVO_NOMBRE" ] && {
		echo "las variables estan vacias"
		return 1
	}

	mv "$ORIGEN"/"$FICHEROS" "$ORIGEN"/"$NUEVO_NOMBRE" && echo "renombrado OK.." || echo "fallo renombrado.." #no existe el comando rename en 
	return 0											#ubuntu por lo que tienes que mover el fichero al mismo directorio pero con otro nombre
}

function moveFiles() {
	getDir || return 1

	read -p "Directorio de destino..........." DESTINO
	[ -z "$DESTINO" ] && {
		echo "las variables estan vacias"
		return 1
	}

	mv "$ORIGEN"/"$FICHEROS" "$DESTINO" && echo "ficheros movidos OK" || echo "fallo al mover ficheros" #pedimos las variables y lo movemos a otra
	return 0																							#ruta sin mas
}

function getDir() { #funcion para pedir el nombre del directorio origen y los fichero(s) que se van a utilizar
	read -p "Introduce directorio donde estan ficheros..." ORIGEN
	read -p "Introduce fichero(s) ..." FICHEROS

	[ -z "$ORIGEN" ] || [ -z "$FICHEROS" ] && {
		echo "las variables estan vacias"
		return 1
	}
	return 0
}

OPCION=0
while [ "$OPCION" -ne 5 ]; do
	clear
	echo -e "\t\t GESTOR FICHEROS"
	echo -e "\t\t ==============="
	echo -e "\t\t 1.Copiar ficheros a un directorio"
	echo -e "\t\t 2.Borrar ficheros de un directorio"
	echo -e "\t\t 3.Renombrar fichero"
	echo -e "\t\t 4.Mover ficheros a un directorio"
	echo -e "\t\t 5.---SALIR"
	read -p "Opcion:_" OPCION

	case $OPCION in
	1) copyFiles ;;
	2) getDir && rm -f "$ORIGEN"/"$FICHEROS" && echo "ficheros borrados OK.." || echo "fallo al borrar fichreos" ;;
	3) renameFile ;;
	4) moveFiles ;;
	5) ;;
	*) echo "opcion invalida...debe ser entre 1 y 5" ;;
	esac
	read -p "presione para continuar" FAKE
	echo "$FAKE"
done
