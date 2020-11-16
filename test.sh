#!/bin/bash -x

set -euo pipefail

export XDG_RUNTIME_DIR=/var/run
export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock

ls -l /var/run/docker.sock

./accept-third-party-license.sh

mkdir -p /tmp/jenkins-home

docker run --rm busybox whoami

docker run -v $DOCKER_HOST:/var/run/docker.sock --rm testcontainers/ryuk:0.3.0

#MAVEN_OPTS="-Duser.name=jenkins -Duser.home=/tmp/jenkins-home" ./mvnw -Pci,all-dbs clean dependency:list test -Dsort -U -B