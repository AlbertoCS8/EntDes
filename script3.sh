#!/bin/bash
#pedir nombre de la app
#mostrar el listado de señales
#pedir el nombre de la señal a mandar al pid
#mandar señal
clear
read -p "dime el nombre de la app... " app 
kill -l
read -p "dime la señal que quieres mandar.. " signal
kill -s $signal `pidof $app`

