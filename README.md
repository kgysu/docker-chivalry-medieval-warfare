# Chivalry: "Medieval Warfare" docker

## Setup initial

1. Change Passwords in `run.sh`
2. Run:

```bash
docker volume create chivalry-data
docker build . -t chivalry
```


## Run server

```bash
docker run -it -v chivalry-data:/opt/chivalry -p 0.0.0.0:8000:8000/udp -p 0.0.0.0:27015:27015/udp chivalry
```

Or use docker-compose:

```bash
docker-compose up
```


## Ressources

### Maps

[Hot To: Custom Maps](https://tornbannerjira.atlassian.net/wiki/spaces/CHIVCOM/pages/13336759/Hosting+a+server+with+custom+content)

Maps:
* 248639339: [Red Wedding](https://steamcommunity.com/sharedfiles/filedetails/?id=248639339)

Add Map with: `-sdkfileid=x`


## In Game config

Open Console: `¨` or `!`

Join Game with: `open <ip>:<port>?password=<pw>`

Admin login: `adminlogin <pw>`

Change Map: `adminchangemap <name>`


## Info

### Features / tested with

* works with mod LSMOD, Blackknight, giantslayers
* most maps (hoth excluded)
* game.ini can be changed reliable
* mods / workshop items can be changed reliable

### known issues

* scripts can be optimized
* no restart if the server has a coredump
* docker-compose network does not work
* use steam user instead of root

