#!/bin/bash -x

set -euo pipefail

# Ignore the fact that rootful Docker is running on the agent
export FORCE_ROOTLESS_INSTALL=1

export XDG_RUNTIME_DIR=/tmp/docker-spring-data

#if [ ! -d $XDG_RUNTIME_DIR ]; then
    echo "Don't appear to have rootless Docker!"

    mkdir -p $XDG_RUNTIME_DIR || true

    cd $XDG_RUNTIME_DIR

    curl -fsSL https://get.docker.com/rootless | sh > rootless-docker-init.sh
#fi

ls -l
ls -lR $XDG_RUNTIME_DIR

cat rootless-docker-init.sh
source <(grep '^export' rootless-docker-init.sh)
PATH=$HOME/bin:$PATH dockerd-rootless.sh --experimental --storage-driver vfs &
sleep 1
export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock
docker info || ls -la $XDG_RUNTIME_DIR
docker ps
docker run --rm busybox whoami
docker run -it -v $XDG_RUNTIME_DIR/docker.sock:/var/run/docker.sock --rm testcontainers/ryuk:0.3.0
