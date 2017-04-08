FROM resin/rpi-raspbian

RUN apt-get update
COPY 01_nodoc /etc/dpkg/dpkg.cfg.d/
RUN apt-get -y install apt-utils
RUN apt-get -y install bash
RUN apt-get -y install autoconf automake m4 libtool build-essential man groff groff-base
RUN apt-get -y install libx11-dev libxft-dev libxinerama-dev libxext-dev
RUN apt-get -y install wget cvs subversion

RUN wget http://fltk.org/pub/fltk/1.3.4/fltk-1.3.4-source.tar.gz
RUN tar xzvf fltk-1.3.4-source.tar.gz
WORKDIR fltk-1.3.4
RUN ./configure --enable-localjpeg --enable-localzlib --enable-localpng --enable-gl=no
RUN make
WORKDIR /
RUN cvs -z3 -d:pserver:anonymous@virtualt.cvs.sourceforge.net:/cvsroot/virtualt co -P VirtualT
COPY Makefile.raspberrypi /VirtualT/Makefile.raspberrypi
WORKDIR VirtualT
RUN make -f Makefile.raspberrypi FLTKDIR=/fltk-1.3.4
ENTRYPOINT ["./virtualt"]
