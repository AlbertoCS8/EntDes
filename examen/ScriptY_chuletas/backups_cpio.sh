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
	echo -e "\t\t $COLOR_VERDE BACKUPS CON CPIO $COLOR_RESET"
	echo -e "\t\t $COLOR_VERDE ---------------- $COLOR_RESET"
	echo -e "\t\t 1. backup total"
	echo -e "\t\t 2. backup incremental"
	echo -e "\t\t 3. == SALIR =="
	echo -n -e "\t\t\t $COLOR_AMARILLO opcion: $COLOR_RESET"; read opcion

	case $opcion in
		1)	echo -n -e "\n\n\n\t\t directorio del que quieres hacer el backup total..."; read dirorigen
			echo -n -e "\t\t directorio de destino donde quieres GUARDAR el backup total..."; read dirdest
			dirorigenreplace=`echo $dirorigen | tr "/" "_"`
			fechabackup=`date +%d%m%Y-%H:%M`

			find $dirorigen \( -type d -o -type f \) -user $USERNAME | cpio -o -v -B > $dirdest/backup_total_${dirorigenreplace}_${fechabackup}.cpio
			;;
		2)
			echo -n -e "\n\n\n\t\t directorio del que quieres hacer el backup total..."; read dirorigen
                        echo -n -e "\t\t directorio de destino donde quieres GUARDAR el backup total..."; read dirdest
                        dirorigenreplace=`echo $dirorigen | tr "/" "_"`
                        fechabackup=`date +%d%m%Y-%H:%M`

			ficheroComparar=`ls $dirdest/backup_total_$dirorigenreplace*.cpio`
			find $dirorigen \( -type d -o -type f \) -user $USERNAME -newer $ficheroComparar | cpio -o -v -B > $dirdest/backup_incremental__$dirorigenreplace_$fechabackup.cpio

			;;
		3)
			exit 0
			;;
		*)
			echo "opcion incorrecta...."
			exit 0
			;;
	esac
	read -p "============== PULSA UNA TECLA PARA CONTINUAR =============" fake
done
