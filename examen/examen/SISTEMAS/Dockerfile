#Primero vamos a especificar la imagen que va a utilizar nuestro Dockerfile
FROM ubuntu:latest

#podemos añadir etiquetas para describir la imagen
LABEL maintainer="Manuel <manuel.diazlaguna@educa.madrid.org>"

#podemos ejecutar comandos por ejemplo si queremos crear el contenedor con ciertos comandos ejecutados
RUN apt-get install -y gparted

#el simbolo \ se utiliza para escapar en este caso nos servira si queremos colocar un comando en varias lineas pero...
    #el sistema lo pillara solo como una
RUN apt-get update -y && \
    apt-get install -y \
    software-properties-common \
    && rm-rf /var/lib/apt/lists/*

#podemos configurar variables de entorno sobre todo sera importante para imagenes como mysql, mongodb, etc
ENV ROOT_PASSWORD="contra"

ENV USER_NAME="usuarioPrueba"

#podemos establecer el directorio de trabajo esto significa que todos los comandos que se van a ejecutar al crear el contenedor se realizaran...
#en esa directorio de trabajo
WORKDIR /app

#podemos copiar fichero locales al contenedor
COPY /home/manuel/Documents/* /app/

#indicamos el puerto que va a utilizar el contenedor para recibir trafico despues se podra utilizar para que el host...
#o otros contenedores se conecten a ese contenedor a traves del puerto
EXPOSE 8080

#comando por defecto al ejecutar el contenedor
CMD ["echo 'hola mundo'"]

#podemos indicar el usuario que utilizara cuando se ejecute el contenedor
USER manuel

#podemos indicar un volumen esto es bastante importante ya que lo que hace es que crea un directorio entre el host y el contenedor el cual...
#compartiran datos incluso si el contenedor se detiene o se elimina. El directorio del host aun mantendra los archivos del directorio conectado del...
#contenedor
VOLUME /app

#---------------------------COMO UTILIZAR EL DOCKERFILE---------------------------#
    #1. vamos a crear el fichero Dockerfile arriba estan gran parte de las opciones que se le pueden añadir...
        #no tienes porque utilizar todos los parametros especificados arriba solo los que sean necesarios para la imagen

    #2. vamos a ejecutar el comando:

        #docker build -t [nombre]:[tag] /ruta/Dockerfile
        #                ---------------- \<-- recomiendo que el nombre y el tag sean diferentes al de la imagen que estas utilizando para evitar...
        #                                       duplicados
        #               si ejecutais el docker image ls se veria algo asi...
        # ej:
        #        ubuntu:latest <-- imagen oficial
        #        ubuntu:tag <-- imagen creada a partir del Dockerfile
        #        mi_app:latest <--- imagen creada a partir del Dockerfile pero con otro nombre aun asi sigue siendo una imagen de ubuntu en este caso


    #3. ahora creamos un contenedor con el Dockerfile:

    #   docker container run -i -t --name miubuntu ubuntu:tag <--- BIEN. utilizara la imagen creada a partir del Dockerfile
    #   docker container run -i -t --name miubuntu ubuntu <-- MAL. utilizara la imagen oficial del docker-hub
    #   docker container run -i -t --name miubuntu mi_app:latest <-- BIEN. aun teniendo otro nombre sigue siendo una imagen de ubuntu modificada...
    #                                                                       MIRAR PASO 2 PARA NO CONFUNDIRSE CON LOS NOMBRES

    #-------------------------------IMPORTANTE-------------------------------#
    #
    #el fichero se debera llamar Dockerfile <-- exactamente asi con la D MAYUSCULA
    #pero si queremos tener varios ficheros Dockerfile podemos hacer esto:
    #
    #   creamos un fichero Dockerfile con un nombre diferente -----> Dockerfile.test
    #   ahora vamos a construir la imagen utilizando el parametro -f <--- este parametro indica cual es el nombre del Dockerfile
    #
    #       docker build -t mi_app:latest /ruta/del/Dockerfile -f Dockerfile.test 