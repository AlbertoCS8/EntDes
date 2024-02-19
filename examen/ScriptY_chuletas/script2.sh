#!/bin/bash
clear
read -p "introduce el nombre de la aplicaciobn para sacar info del proceso" aplicacion
echo "inicio del script"
echo " la variable de la aplicacion vale... $aplicacion"
ps -o pid,ppid,pri,state,cmd -C $aplicacion
echo "fin del script"


