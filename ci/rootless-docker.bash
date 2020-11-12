#!/bin/bash -x

set -euo pipefail

# Ignore the fact that rootful Docker is running on the agent
FORCE_ROOTLESS_INSTALL=1

XDG_RUNTIME_DIR=/tmp/docker-spring-data

if [ ! -d $XDG_RUNTIME_DIR ]; then
    echo "Don't appear to have rootless Docker!"

    mkdir -p $XDG_RUNTIME_DIR || true

    curl -fsSL https://get.docker.com/rootless | sh > init.sh
    cat init.sh
fi

source <(grep '^export' init.sh)
PATH=$HOME/bin:$PATH dockerd-rootless.sh --experimental --storage-driver vfs &
sleep 1
DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock docker info || ls -la $XDG_RUNTIME_DIR