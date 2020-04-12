FROM ubuntu
MAINTAINER kgysu none@gmail.com

################################################################################
## exposing 8000 and 27015 on udp
EXPOSE 8000:8000/udp
EXPOSE 27015:27015/udp

################################################################################
## app deps
RUN set -x && \
    dpkg --add-architecture i386 && \
    apt-get update -qq && \
    apt-get install -qq curl libstdc++6:i386 lib32gcc1

################################################################################
## cleaning as root
RUN apt-get clean autoclean purge && \
    rm -fr /tmp/*

RUN useradd -r -m -u 1000 steam

################################################################################
## volume
RUN mkdir -p /opt/chivalry && \
    chown steam -R /opt/chivalry && \
    chmod 755 -R /opt/chivalry

################################################################################
## copy run script
COPY run.sh /usr/local/bin/run-chivalry
## copy game.ini template
COPY PCServer-UDKGame.ini /usr/local/bin/PCServer-UDKGame.ini

################################################################################

## change to user steam
USER steam

## install steamcmd
RUN mkdir -p /opt/chivalry/steamcmd
WORKDIR /opt/chivalry/steamcmd
RUN pwd
RUN curl -Ss http://media.steampowered.com/installer/steamcmd_linux.tar.gz | tar -xz

## install chivalry
RUN "/opt/chivalry/steamcmd/steamcmd.sh" +login anonymous +force_install_dir "/opt/chivalry/server" +app_update 220070 +quit
RUN ln -s "/opt/chivalry/steamcmd/linux32/steamclient.so" "/opt/chivalry/server/Binaries/Linux/lib/steamclient.so"
RUN echo "219640" > "/opt/chivalry/server/Binaries/Linux/steam_appid.txt"

## install configurations
RUN mkdir -p /opt/chivalry/config
WORKDIR /opt/chivalry/config
RUN ln -s ../server/UDKGame/Config/PCServer-UDKGame.ini PCServer-UDKGame.ini
RUN mkdir -p "/home/steam/.local/share/TornBanner/Chivalry"
RUN ln -s /opt/chivalry/server/UDKGame /home/steam/.local/share/TornBanner/Chivalry/UDKGame
RUN cp /usr/local/bin/PCServer-UDKGame.ini /opt/chivalry/server/UDKGame/Config/PCServer-UDKGame.ini

## set env
ENV LD_LIBRARY_PATH=/opt/chivalry/server/linux64:/opt/chivalry/server/Binaries/Linux/lib
ENV SERVER_PORT=8000
ENV SERVER_ADMIN_PORT=27015
ENV ADMIN_PASSWORD="defaultAdmin"
ENV USER_PASSWORD="default"

WORKDIR /opt/chivalry/server/Binaries/Linux

CMD ["/usr/local/bin/run-chivalry"]
