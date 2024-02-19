#!/bin/bash
clear

read -p "nombre de la app de la q quieres cambiar prioridad_" app

ps -C "$app" -o pri,nice,cmd

bondad=99
while [ "$bondad" -gt 20 ] || [ "$bondad" -lt -19 ]
do
	read -p "nuevo valor de la bondad para el proceso +20 a -19_" bondad
done

sudo renice -n "$bondad" -p "$(pidof "$app")"
echo "...CAMBIADA LA BONDAD DEL PROCESO, y por tanto su PRIORIDAD..."

ps -C "$app" -o pri,nice,cmd