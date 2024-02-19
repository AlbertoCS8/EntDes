#! /bin/bash
COLOR_RESET="\e[0m"
COLOR_ROJO="\e[31m"
COLOR_AZUL="\e[34m"
COLOR_AMARILLO="\e[33m"
COLOR_VERDE="\e[32m"

opcion=0
while [ $opcion -ne 3 ]
do
	clear
	echo -e "\t\t $COLOR_VERDE GESTION DE USUARIOS$COLOR_RESET"
	echo -e "\t\t $COLOR_VERDE --------------- $COLOR_RESET"
	echo -e "\t\t 1. Crear nuevo usuario"
	echo -e "\t\t 2. Borrar usuario"
	echo -e "\t\t 3. Cambiar password de usuario"
	echo -e "\t\t 4. Añadir usuario a un grupo"
	echo -e "\t\t 5. == SALIR =="
	echo -n -e "\t\t\t $COLOR_AMARILLO opcion: $COLOR_RESET"; read opcion

	case $opcion in
		1)	echo -n -e "\n\n\n\t\t Dime nombre de usuario"; read nombreUser
			[ -z "$nombreUser" ] && { echo -e "No puede estar en blanco" }
			exit 0
			fi
			echo -n -e "\n\n\n\t\t Dime Contraseña de usuario"; read contraUser
			if $contraUser==""
			then
			exit 0
			fi
			echo -n -e "\n\n\n\t\t Dime nombre de grupo"; read grupoUser
			if grep -e "$grupouser:x:" /etc/group > /dev/null 
			then groupadd $grupoUser
			fi
			useradd $numbreUser
			;;
		2)
			ficheroComparar=
			find $direorigen \( -type d -o -type f \) -user $USERNAME | cpio -o -v -B > $dirdest/backup_total_$dirorigen_$fechabackup.cpio
			;;
		3)
			exit 0
			;;
		*)
			echo "opcion incorrecta...."
			exit 0
			;;
	esac
	sleep 3s
done
