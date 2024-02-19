#!/bin/bash

#quiero saber el pid,ppid,prioridad,statdo y  comando
#del proceso asociado a la aplicacion almacenada en esa 
#variable...

clear
read -p "Introduce el nombre de la aplicacion para sacar info proceso:_" aplicacion
echo "----- INICIO DEL SCRIPT -----"
echo "la variable aplicacion vale....$aplicacion"

ps -o pid,ppid,pri,state,cmd -C "$aplicacion"

echo "----- FIN DEL SCRIPT -----" 


