# Chivalry: "Medieval Warfare" Server

## Requirements

* Running Docker (tested with WSL2)
* Optional: Kubernetes
* Create folder for volume in `~/volumes/chivalry`


## Setup

Initial:

1. Edit Credentials in `start.sh` or `chivalry-statefulset.yaml`
    * adminpassword=some
    * password=some
3. Build Dockerimage

```bash
docker build . -t chivalry
```


### Run

```bash
docker run -it -v ~/volumes/chivalry:/home/steam/games/chivalry -p 0.0.0.0:8000:8000/udp -p 0.0.0.0:27015:27015/udp --name chivalry chivalry
```

Or run on Kubernetes: `/kube`


## Ressources

### Maps

[How To: Custom Maps](https://tornbannerjira.atlassian.net/wiki/spaces/CHIVCOM/pages/13336759/Hosting+a+server+with+custom+content)

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

