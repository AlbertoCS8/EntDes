#!/bin/bash
aplicacion="firefox"
clear
echo "---inicioi del script"
echo "la variable vale... $aplicacion"
ps -o pid,ppid,pri,state,cmd -C $aplicacion
echo "fin del script"
