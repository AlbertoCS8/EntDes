#!/bin/bash
echo -e "\t\t\t MENU"
echo -e "\t\t 1. Backup Total"
echo -e "\t\t 2. Backup Incremental"
echo -e "\t\t 3. Salir"
echo -e "Elige la opcion"
read -N 1 opcion

while [ $opcion -gt 3 ]
	do
		echo "Introduce una opcion valida"
		read -N 1 opcion
done
while [ $opcion -lt 3 ]
	do
		if [ $opcion -eq 1 ]
			then
				while true
				do
					read -p "introduce la ruta de donde quieres hacer el backup" dirori
					if [ -d $dirori ]
						then
							break
						else
							read -p "introduce una ruta valida" dirori				
					fi
			done
				while true
				do
					read -p "introduce la ruta de destino" dirdest
					if [ -d $dirdest ]
						then
							break
						else
							read -p "introduce una ruta valida" dirdest				
					fi
			done
			
		fi
done
		
		


