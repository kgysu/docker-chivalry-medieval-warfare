FROM ubuntu:18.04

################################################################################
## exposing 8000 and 27015 on udp
EXPOSE 8000:8000/udp
EXPOSE 27015:27015/udp

################################################################################
## app deps
RUN set -x && \
    dpkg --add-architecture i386 && \
    apt-get update -qq && \
    apt-get install -qq curl libstdc++6:i386 lib32gcc1 dos2unix nano

## Install Steamcmd
RUN echo steam steam/question select "I AGREE" | debconf-set-selections
RUN apt-get install steamcmd
RUN ln -s /usr/games/steamcmd /usr/local/bin/steamcmd

################################################################################
## cleaning as root
RUN apt-get clean autoclean purge && \
    rm -fr /tmp/*

RUN useradd -r -m -u 1000 steam

################################################################################
## volume
RUN mkdir -p /home/steam/games/chivalry && \
    chown steam -R /home/steam/games/chivalry && \
    chmod 755 -R /home/steam/games/chivalry

################################################################################
## copy run script
COPY --chown=steam install.sh /home/steam/install.sh
RUN dos2unix /home/steam/install.sh

COPY --chown=steam start.sh /home/steam/start.sh
RUN dos2unix /home/steam/start.sh

COPY --chown=steam update.txt /home/steam/update.txt
RUN dos2unix /home/steam/update.txt

## copy game.ini template
COPY --chown=steam PCServer-UDKGame.ini /home/steam/PCServer-UDKGame.ini
RUN dos2unix /home/steam/PCServer-UDKGame.ini

################################################################################
## app run
USER steam

WORKDIR /home/steam/games/chivalry/Binaries/Linux

ENTRYPOINT /home/steam/start.sh
