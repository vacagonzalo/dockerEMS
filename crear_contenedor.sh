#!/bin/bash

# El comentario que comienza con un signo de exclamación
# tiene la finalidad de indicarle al sistema con que binario
# debe ejecutar este archivo, en nuestro caso el intérprete de
# BASH

# Se define el directorio del host como "path to working directory"
# (PWD), esto es, la carpeta desde donde lanzamos este script.
DIRECTORIO_DE_MI_MAQUINA=PWD

docker run -ti \
    -e DISPLAY=$DISPLAY \
    --net="host" \
    --name="UNLaM" \
    --hostname="UNLAM" \
    -v $DIRECTORIO_DE_MI_MAQUINA:/home/dev/workspace \
    openems
    /bin/bash