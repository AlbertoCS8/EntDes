#! /bin/bash

#FINISHED

#-------------------------------------------------------------------------------------------------------------------------#
#---------------------------------------------------FUNCIONES-DE-BACKUPS--------------------------------------------------#
#-------------------------------------------------------------------------------------------------------------------------#
function listarContenedor() {
    clear
    echo -n -e "\n\n\t\t\t listar todos los contenedores o solo los UP [s=todos,n=up]"
    read LI

    case $LI in
    "s") docker container ps -a ;; #dependiendo de la opcion vamos a listar todos o solo los activos
    "n") docker container ps ;;
    *)
        echo "no has elegido una opcion correcta"
        return 1
        ;;
    esac
    return 0
}

function ejecutarComando() {
    clear
    comprobar_contenedor || return 1
    checkValidContainer || return 1

    docker exec -i -t "$CONTENEDOR_NOMBRE" /bin/bash >/dev/null 2>/dev/null || { #si al ejecutar el comando se produce un error haremos esto
        #el error especialmente ocurrira porque no se puede ejecutar
        echo "no se puede ejecutar el comando porque la maquina esta detenida y no se puede arrancar" #el comando en un docker que no esta UP
        read -p "quieres volver a crear el contenedor con la misma imagen [y/n]?:_" CONTENEDOR_VARIABLE
        case $CONTENEDOR_VARIABLE in
        "y")
            CONTENEDOR_IMAGEN=$(docker container ps -a | grep -v "IMAGE" | grep "$CONTENEDOR_NOMBRE" | awk '{print $2}') #se guarda la imagen del contenedor
            docker container stop "$CONTENEDOR_NOMBRE" >/dev/null
            docker container rm "$CONTENEDOR_NOMBRE" >/dev/null
            docker container run -i -t --name "$CONTENEDOR_NOMBRE" "$CONTENEDOR_IMAGEN" #se volvera a crear el contenedor con el mismo nombre
            ;;                                                                          #y tambien la misma imagen pero puede cascar si la imagen
        "n") echo "saliendo de la opcion..." ;;                                         #requiere variables que se definan al crear el contenedor
        *)
            echo "opcion incorrecta"
            return 1
            ;;
        esac
    }
    return 0
}

function crearContenedor() {
    clear
    DOCKER_CMD="docker container run -i -t" #se va a guardar el principio del comando y se ira añadiendo parametros
    comprobar_contenedor || return 1
    DOCKER_CMD+=" --name $CONTENEDOR_NOMBRE" #se añade al comando el parametro --name con el nombre especificado antes

    read -p "quieres ejecutarlo en segundo plano [y/n]:_" DOCKER_DEMON
    case $DOCKER_DEMON in
    "y") DOCKER_CMD+=" -d" ;; #en caso de que se indique se añade el parametro de -d [DAEMON segundo plano]
    "n") ;;                   #dependiendo de la imagen cuando se cree se va a cerrar el docker prueben con la imagen de ubuntu
    *)
        echo "opcion incorrecta"
        return 1
        ;;
    esac

    read -p "quieres añadir variables [y/n]:_" CONTENEDOR_VARIABLE
    case $CONTENEDOR_VARIABLE in
    "n") ;;
    "y") setVariables || { #si se indica se ira a esta funcion en la cual añadiremos las variables a definir en el contenedor
        echo "error definiendo las variables"
        return 1
    } ;;
    *)
        echo "opcion incorrecta"
        return 1
        ;;
    esac

    read -p "que imagen quieres utilizar:_" CONTENEDOR_IMAGEN
    [ -z "$CONTENEDOR_IMAGEN" ] && {
        echo "esta vacia la variable"
        return 1
    }

    mapfile -t ARRAY < <(docker search "$CONTENEDOR_IMAGEN" | grep -v "NAME" | awk '{print $1}') #vamos a guardar en un array el resultado del comando
    CONTADOR=1                                                                                   #con el mapfile -t lo que haremos es que en el array se guardara el resultado teniendo en cuenta que el comando devuelve valores en varias lineas
    for i in "${ARRAY[@]}"; do
        echo "${CONTADOR}.$i" #recorremos el array y mostramos cada posicion de esta forma puedes elegir que imagen quieres a traves de una busqueda
        CONTADOR=$((CONTADOR + 1))
    done

    read -p "que opcion quieres:_" IMAGEN_NUMBER #ahora pedimos que posicion queremos y esa sera la imagen que elegimos
    isIntenger "$IMAGEN_NUMBER" || {
        echo "opcion incorrecta"
        return 1
    }
    DOCKER_CMD+=" ${ARRAY[$((IMAGEN_NUMBER - 1))]}" #añadimos al comando la imagen que hemos elegido del array

    eval "$DOCKER_CMD" #con el eval ejecutamos lo que contenga el valor de la variable como un comando
    echo "se ha creado el contenedor $CONTENEDOR_NOMBRE"
    return 0
}

function setVariables() { #con esta funcion vamos a añadir de forma dinamica las variables en la funcion crearContenedor
    clear
    read -p "cuantas variables quieres añadir:_" VAR_SIZE

    isIntenger "$VAR_SIZE" || {
        echo "debes introducir un numero entero"
        return 1
    }

    for ((i = 1; i <= $VAR_SIZE; i++)); do #recorremos un for y preguntamos el nombre y valor de la variable
        read -p "nombre de la variable:_" VAR_NAME
        read -p "valor de la variable:_" VAR_VALUE

        DOCKER_CMD+=" -e ${VAR_NAME}=${VAR_VALUE}" #ahora añadimos la variable con su valor dentro del comando
    done
}

#-------------------------------------------------------------------------------------------------------------------------#
#-------------------------------------------------FUNCIONES-DE-COMPROBACION-----------------------------------------------#
#-------------------------------------------------------------------------------------------------------------------------#
function isIntenger() { #con esta funcion comprobaremos que la variable ingresada es un numero
    [[ $1 =~ ^[0-9]+$ ]]
}

function comprobar_contenedor() { #con esta funcion comprobaremos que la variable del nombre del contenedor no esta vacia
    clear
    echo -n -e "\n\n\t\t\t nombre del contenedor:_"
    read CONTENEDOR_NOMBRE
    [ -z "$CONTENEDOR_NOMBRE" ] && {
        echo "la variable esta vacia"
        return 1
    }
    return 0
}

function checkValidContainer() { #con esta funcion comprobaremos que el contenedor proporcionado existe
    CONTENEDOR_VARIABLE=$(docker container ps -a | grep -e "$CONTENEDOR_NOMBRE$")
    [ -z "$CONTENEDOR_VARIABLE" ] && {
        echo "no se ha encontrado el contenedor"
        return 1
    }
    return 0
}

#-------------------------------------------------------------------------------#
#----------------------------- main --------------------------------------------#
#-------------------------------------------------------------------------------#
OPCION=0
while [ "$OPCION" -ne 7 ]; do #hacemos el while para no salir del menu
    clear
    echo -e "\t\t\t ADMINISTRACION CONTAINERS-DOCKER"
    echo -e "\t\t\t ================================"
    echo -e "\t\t\t 1. Listar contenedores"
    echo -e "\t\t\t 2. Parar contenedor"
    echo -e "\t\t\t 3. Arrancar contenedor"
    echo -e "\t\t\t 4. Borrar contenedor"
    echo -e "\t\t\t 5. Ejecutar comando en contenedor"
    echo -e "\t\t\t 6. Crear contenedor"
    echo -e "\t\t\t 7. --SALIR--"
    echo -n -e "\n\t\t\t\t Opcion:_"
    read OPCION

    isIntenger "$OPCION" || {
        echo "no has ingreado un numero"
        OPCION=0
    }

    case $OPCION in
    1) listarContenedor ;;
    2) comprobar_contenedor && checkValidContainer && docker container stop "$CONTENEDOR_NOMBRE" ;;
    3) comprobar_contenedor && checkValidContainer && docker container start "$CONTENEDOR_NOMBRE" ;;
    4) comprobar_contenedor && checkValidContainer && {
        docker container stop "$CONTENEDOR_NOMBRE"
        docker container rm "$CONTENEDOR_NOMBRE"
    } ;;
    5) ejecutarComando ;;
    6) crearContenedor ;;
    7) exit 0 ;;
    esac
    read -p "Presione para continuar" FAKE
    echo "$FAKE"
done
