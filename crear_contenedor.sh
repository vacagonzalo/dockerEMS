#!/bin/bash

# El comentario que comienza con un signo de exclamación
# tiene la finalidad de indicarle al sistema con que binario
# debe ejecutar este archivo, en nuestro caso el intérprete de
# BASH

# Se define el directorio de nuestra máquina para poder
# extraer los archivos que están adentro del contenedor
DIRECTORIO_DE_MI_MAQUINA=/home/gonzalo/workspace/dockerEMS

docker run -ti \
    -e DISPLAY=$DISPLAY \
    --net="host" \
    --name="UNLaM" \
    --hostname="UNLAM" \
    -v $DIRECTORIO_DE_MI_MAQUINA:/home/dev/workspace \
    openems
    /bin/bash