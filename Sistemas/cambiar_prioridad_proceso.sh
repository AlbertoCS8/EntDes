#!/bin/bash
clear

#1º paso: pedir el nombre de la aplicacion de la que quieres cambiar prioridad del proceso
read -p "nombre de la app de la q quieres cambiar prioridad_" app

#2º paso: mostrar prioridad actual  del proceso asociado
ps -C $app -o pri,nice,cmd


#3º paso: cambiar prioridad del mismo, pidiendo nuevo valor de la bondad (nice, renice)
#si el valor metido es mayor de 20 o menor de -19 mostrar error y salir del script

bondad=99
while [ $bondad -gt 20 -o $bondad -lt -19 ]
do
	read -p "nuevo valor de la bondad para el proceso +20 a -19_" bondad
done

#if [ $bondad -gt 20 -o $bondad -lt -19 ]
#then
#	echo "...valor incorrecto de la bondad, por favor entre +20 y -19.."
#	exit 0
#fi

sudo renice -n $bondad -p `pidof $app`
echo "...CAMBIADA LA BONDAD DEL PROCESO, y por tanto su PRIORIDAD..."

#4º paso: mostrar prioridad actual cambiada del proceso
ps -C $app -o pri,nice,cmd
