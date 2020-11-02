#!/usr/bin/env bash

if [ ! -d "/home/steam/games/chivalry/UDKGame" ]; then
  echo "game not found! starting install..."
  sh /home/steam/install.sh
  echo "game installed!"
fi

if [ ! -f "/home/steam/games/chivalry/UDKGame/Config/PCServer-UDKGame.ini" ]; then
  echo "PCServer-UDKGame.ini not found! Creating.."
  cp /home/steam/PCServer-UDKGame.ini /home/steam/games/chivalry/UDKGame/Config/PCServer-UDKGame.ini
fi

if [ ! -L '/home/steam/games/chivalry/Binaries/Linux/lib/steamclient.so' ]; then
  echo "Link steamclient.."
  ln -s '/home/steam/games/chivalry/steamclient.so' '/home/steam/games/chivalry/Binaries/Linux/lib/steamclient.so'
fi

if [ ! -f '/home/steam/games/chivalry/Binaries/Linux/steam_appid.txt' ]; then
  echo "create appid.."
  echo '219640' >'/home/steam/games/chivalry/Binaries/Linux/steam_appid.txt'
fi

echo "Start Game"

export LD_LIBRARY_PATH=/home/steam/games/chivalry/linux64:/home/steam/games/chivalry/Binaries/Linux/lib

./UDKGameServer-Linux AOCFFA-Moor_p\?steamsockets\?Port=8000\?QueryPort=27015\?adminpassword=chivadminl42\?password=closed4u -sdkfileid=248639339 -seekfreeloadingserver