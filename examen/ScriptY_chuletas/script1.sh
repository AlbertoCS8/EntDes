#!/bin/bash
#asignamos un nombre a la variable y lw damos valor
#con el igual =
aplicacion="firefox"
clear
echo "---inicio del script"
echo "la variable vale... $aplicacion"
ps -o pid,ppid,pri,state,cmd -C $aplicacion
echo "fin del script"
