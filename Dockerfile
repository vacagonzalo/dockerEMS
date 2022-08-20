# Universidad Nacional de la Matanza, República Argentina.

# Los Dockerfiles comienzan instanciando una imagen base
FROM ubuntu:focal

# En esta sección se actualiza la base de datos del gestor
# de paquetes (apt) y se procede a instalar las herramientas
# y sus dependencias
RUN apt-get update &&  DEBIAN_FRONTEND=noninteractive apt-get install -y -q \
  octave-common \
  openems \
  octave-openems \
  libcsxcad0

# Se genera un usuario de desarrollo (dev) con permisos de
# administrador y sin necesidad de ingresar su contraseña
RUN adduser --disabled-password --gecos '' dev && \
  usermod -aG sudo dev && \
  echo "dev ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Se hace /bin/sh symlink a bash en vez de dash:
RUN echo "dash dash/sh boolean false" | debconf-set-selections
RUN DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash

# Cuando se ingrese al contenedor se ingresará como dev
USER dev
ENV HOME /home/dev
ENV LANG en_US.UTF-8

# Se crea una carpeta de trabajo y se la configura como
# workdir
RUN mkdir /home/dev/workspace
WORKDIR /home/dev/workspace