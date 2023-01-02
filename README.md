# pluGET-docker
Docker image for the [pluGet](https://github.com/Neocky/pluGET) Minecraft plugin package manager.

## Quick Start

```sh
docker run -v /home/pi/mcserver:/data:rw -it bobrollenhagen/pluget:latest
```

Plugins should only be updated when the minecraft server is stopped.

## Configuration
The container uses a default configuration file which will store plugins to /data/plugins. 

By default, all files will be owned by a non-root user 9001:9001 for compatibility with [mtoensing's PaperMC docker image](https://github.com/mtoensing/Docker-Minecraft-PaperMC-Server). To change the user and group, add the following to your docker run command:

```sh
-e PUID=XXX
-e GPID=XXX
```

## Docker Compose
```yaml
version: "3.9"
services:
  pluget:
    image: "bobrollenhagen/pluget:latest"
    restart: always
    container_name: "pluget"
    volumes:
      - "/home/pi/mcserver:/data/:rw"
    stdin_open: true
    tty: true
```

## Credits
pluGET:  https://github.com/Neocky/pluGET

Docker-Minecraft-PaperMC-server: https://github.com/mtoensing/Docker-Minecraft-PaperMC-Server

The docker-entrypoint.sh code is based on mtoensing's script.

