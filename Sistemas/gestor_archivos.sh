#!/bin/bash
opcion=0

while [ $opcion -ne 5 ]
do
	clear
	echo -e "\t\t GESTOR FICHEROS"
	echo -e "\t\t ==============="
	echo -e "\t\t 1.Copiar ficheros a un directorio"
	echo -e "\t\t 2.Borrar ficheros de un directorio"
	echo -e "\t\t 3.Renombrar fichero"
	echo -e "\t\t 4.Mover ficheros a un directorio"
	echo -e "\t\t 5.---SALIR"
	read -p "Opcion:_" opcion

	case $opcion in
		1)	read -p "Introduce directorio donde estan ficheros..." origen
			read -p "Introduce fichero(s) a copiar..." fich
			read -p "Directorio de destino..........." direct
			cp $origen/$fich  $direct && echo "ficheros copiados OK..." || echo "fallo al copiar ficheros"
			;;

		2)	read -p "Introduce directorio donde estan ficheros a borrar..." origen
			read -p "Introduce fichero(s) a borrar........................" fich
			rm -f $origen/$fich && echo "ficheros borrados OK.." || echo "fallo al borrar fichreos"
			;;

		3)	read -p "Introduce directorio donde esta fichero a renombrar..." origen
			read -p "Introduce fichero a renombrar........................" fich
			read -p "Introduce nuevo nombre..............................." newname
			mv $origen/$fich  $origen/$newname && echo "renombrado OK.." || echo "fallo renombrado.."
			;;

		4)	read -p "Introduce directorio donde estan fichero(s) a mover..." origen
			read -p "Introduce fichero(s) a mover.........................." fich
			read -p "Directorio de destino..........." direct
			mv $origen/$fich  $direct && echo "ficheros movidos OK" || echo "fallo al mover ficheros"
			;;

		5)	echo "...saliendo del script..."
			exit 0
			;;
		*)
			echo "opcion invalida...debe ser entre 1 y 5"
			;;
	 esac
	 sleep 10s
done
