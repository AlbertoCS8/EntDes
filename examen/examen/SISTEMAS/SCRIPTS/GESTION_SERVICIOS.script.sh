#!/bin/bash

# script q te pida el nombre de un servicio
# comprobar su estado...
clear
read -p "introduce el nombre del servicio, p.e: cron__" serv

echo -e "\t\t ESTADO DEL SERVICIO"
echo -e "\t\t -------------------"

systemctl status "$serv".service

echo -e "-------------------------------------------- \n\n"

estado=$(systemctl is-enabled "$serv".service)
if [ "$estado" == "enabled" ]
then
	# si esta ENABLED y RUNNING, te tiene q preguntar si quieres pararlo
	# si la respuesta es q "S" o "s", lo paras

	# si esta ENABLED y STOPPED, te tiene q preguntar si quieres arrancarlo
	# si la respuesta es q "S" o "s", lo arrancas

	isrunning=$(systemctl list-units --type=service | grep "$serv.service" | awk '{print $4}')
	if [ "$isrunning" == "running" ]
	then
		read -p "el servicio esta ejecutandose, lo quieres PARAR [s/n]___" resp
		[ "$resp" == "s" ] || [ "$resp" == "S" ] && systemctl stop "$serv".service

	else
		read -p "el servicio esta parado, lo quieres ARRANCAR [s/n]___" resp
		[ "$resp" == "s" ] || [ "$resp" == "S" ] && systemctl start "$serv".service

	fi
else
	# si esta DISABLED, te tiene q preguntar si lo quieres habilitar
	# si la respuesta es "S" o "s", lo habilitas
	read -p "el servicio esta deshabilitado, lo quieres HABILITAR [s/n]___" resp

	[ "$resp" == "s" ] || [ "$resp" == "S" ] && systemctl enable "$serv".service

fi