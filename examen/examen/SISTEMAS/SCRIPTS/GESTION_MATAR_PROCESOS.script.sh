#!/bin/bash

# 1Âºpaso:  te tiene que pedir el nombre de la aplicacion de la cual quiero manejar
# proceso
read -p "introduce el nombre de la aplicacion:_" app

# 2Âº paso: te tiene q mostrar por pantalla el listado de seÃ±ales
kill -l

# 3Âº paso: te tiene q pedir el nombre de la seÃ±al a mandar al pid de ese proceso
read -p "nombre de la seÃ±al a mandar:_" signal

# 4Âº paso: mandar seÃ±al
kill -s "$signal" "$(pidof "$app")"







