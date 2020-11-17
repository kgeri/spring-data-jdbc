#!/bin/bash -x

set -euo pipefail

export XDG_RUNTIME_DIR=/tmp/docker-spring-data
#export DOCKER_HOST=unix:///var/run/docker.sock

ls -l $XDG_RUNTIME_DIR/docker.sock

./accept-third-party-license.sh

mkdir -p /tmp/jenkins-home

docker run --rm busybox whoami

docker info
docker ps
docker images

#docker run -v $XDG_RUNTIME_DIR/docker.sock:/var/run/docker.sock --rm testcontainers/ryuk:0.3.0

XDG_RUNTIME_DIR=/tmp/docker-spring-data MAVEN_OPTS="-Duser.name=jenkins -Duser.home=/tmp/jenkins-home" ./mvnw -Pci,all-dbs clean dependency:list test -Dsort -U -B
