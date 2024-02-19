#!/bin/bash

# 1ºpaso:  te tiene que pedir el nombre de la aplicacion de la cual quiero manejar
# proceso
read -p "introduce el nombre de la aplicacion:_" app

# 2º paso: te tiene q mostrar por pantalla el listado de señales
kill -l

# 3º paso: te tiene q pedir el nombre de la señal a mandar al pid de ese proceso
read -p "nombre de la señal a mandar:_" signal

# 4º paso: mandar señal
kill -s $signal `pidof $app`








