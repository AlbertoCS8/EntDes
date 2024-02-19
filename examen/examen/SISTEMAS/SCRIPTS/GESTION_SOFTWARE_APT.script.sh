#!/bin/bash

#-------------------------------------------------------------------------------------------------------------------------#
#---------------------------------------------------FUNCIONES-DE-SOFTWARE-------------------------------------------------#
#-------------------------------------------------------------------------------------------------------------------------#
function addrepo() {
    echo -n -e "\n\t\t\t url donde se encuentra la clave publica del repo:_"
    read url

    echo -n -e "\t\t\t nombre clave:_"
    read nombreclave
    [ -z "$nombreclave" ] && {
        echo "...no puede estar vacio el nombre del fichero donde vamos a guardar la clave..."
        return 1
    }

    curl "$url" | sudo tee /etc/apt/keyrings/"$nombreclave".gpg

    echo -n -e "\n\t\t\t url del repo:_"
    read urlrepo
    [ -z "$urlrepo" ] && {
        echo "...no puede estar vacio la URL del repoÂº..."
        return 1
    }

    echo "dev [signed-by=/etc/apt/keyrings/$nombreclave.gpg] $urlrepo $(lsb_release -c | awk '{print $2}') stable" |
        sudo tee /etc/apt/sources.list.d/"$nombreclave".list
}

function instapp() {
    pedirNombre || return 1
    sudo apt update && sudo apt upgrade -y
    sudo apt install "$paquete"
    #return 0
}

function removeapp() {
    pedirNombre || return 1
    apt list | grep -e "^$paquete/" >/dev/null || {
        echo -e "\t\t\t ... parece que no esta instalado $paquete ..."
        return 1
    }
    sudo apt purge "$paquete"
    #return 0
}

function searchapp() {
    pedirNombre || return 1
    apt search "$paquete" | grep -e "^$paquete.*/" #...tambien vale: apt-cache search -n ^$paquete
    #return 0
}

#-------------------------------------------------------------------------------------------------------------------------#
#-------------------------------------------------FUNCIONES-DE-COMPROBACION-----------------------------------------------#
#-------------------------------------------------------------------------------------------------------------------------#
function pedirNombre() { #funcion para pedir el nombre del paquete
    echo -n -e "\n\t\t\t introduce nombre paquete :_"
    read paquete

    [ -z "$paquete" ] && {
        echo -e "\t\t\t ...el nombre del paquete no puede estar vacio"
        return 1
    }
    return 0
}

# -----------------------------------------------------------------------------#
# ---------------------------------- main -------------------------------------#
#------------------------------------------------------------------------------#
OPCION=0
while [ "$OPCION" -ne 5 ]; do
    clear
    echo -e "\n\t\t\t GESTION SOFTWARE VIA APT"
    echo -e "\t\t\t ========================"
    echo -e "\t\t\t 1. AÃ±adir nuevo repo y su clave publica"
    echo -e "\t\t\t 2. Instalar paquete software "
    echo -e "\t\t\t 3. Borrar paquete software instalado"
    echo -e "\t\t\t 4. Buscar paquete por nombre"
    echo -e "\t\t\t 5. ---- SALIR ----"
    echo -n -e "\t\t\t\t Opcion:_"
    read -n 1 OPCION

    case $OPCION in
    1) addrepo ;;
    2) instapp ;;
    3) removeapp ;;
    4) searchapp ;;
    5) exit 0 ;;
    esac
    sleep 5s

done
