#!/bin/sh
set -e

DOCKER_USER='dockeruser'
DOCKER_GROUP='dockergroup'

if ! id "$DOCKER_USER" >/dev/null 2>&1; then
    echo "First start of the docker container, start initialization process."

    USER_ID=${PUID:-9001}
    GROUP_ID=${PGID:-9001}
    echo "Starting with $USER_ID:$GROUP_ID (UID:GID)"

    addgroup --gid $GROUP_ID $DOCKER_GROUP
    adduser $DOCKER_USER --shell /bin/sh --uid $USER_ID --ingroup $DOCKER_GROUP --disabled-password --gecos ""

    #chown -vR $USER_ID:$GROUP_ID /opt/pluget
    #chmod -vR ug+rwx /opt/pluget
    mkdir -p /data/plugins
    chown -vR $USER_ID:$GROUP_ID /data
fi

export HOME=/home/$DOCKER_USER

PLUGETCFG=pluGET_config.yaml
PLUGETDIR=/opt/pluget
PLUGET=$PLUGETDIR/pluget.py

if ! test -f "$PLUGETCFG"
then
        cp "$PLUGETDIR/$PLUGETCFG" .
	chown $USER_ID:$GROUP_ID "$PLUGETCFG"
fi
 


exec gosu ${PUID:-9001}:${PGID:-9001} python3 /opt/pluget/pluget.py 
#exec gosu ${PUID:-9001}:${PGID:-9001} /bin/bash
#exec /bin/bash
