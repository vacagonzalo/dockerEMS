# Universidad Nacional de la Matanza, República Argentina.

# Los Dockerfiles comienzan instanciando una imagen base
FROM ubuntu:xenial

# En esta sección se actualiza la base de datos del gestor
# de paquetes (apt) y se procede a instalar las herramientas
# y sus dependencias
RUN apt-get update &&  DEBIAN_FRONTEND=noninteractive apt-get install -y -q \
  autoconf \
  bison \
  build-essential \
  cmake \
  epstool \
  flex \
  gengetopt \
  git \
  groff \
  help2man \
  libboost-all-dev \
  libcgal-dev \
  libcgal-qt5-dev \
  libhdf5-dev \
  libhpdf-dev \
  liboctave-dev \
  libqt4-dev \
  libtinyxml-dev \
  libtool \
  libvtk5-dev \
  libvtk5-qt4-dev \
  octave \
  paraview\
  pod2pdf \
  transfig \
  wget

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

# Se descarga openEMS como tarball
RUN wget https://openems.de/download/src/openEMS-v0.0.35.tar.bz2

# Se desenpaqueta el tarball
RUN tar jxf openEMS-v0.0.35.tar.bz2

# Se instala openEMS
RUN cd openEMS && ./update_openEMS.sh ~/opt/openEMS --with-hyp2mat --with-CTB
