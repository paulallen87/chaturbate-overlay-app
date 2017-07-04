#!/bin/bash

cd $(dirname "${0}")
BASEDIR=$(pwd -L)
cd ..

docker build \
  --tag paulallen87/chaturbate-overlay-app-shell \
  --file ${BASEDIR}/../Dockerfile-dev \
  .

docker rm -f cb-overlay-app-shell

docker run \
  -ti \
  --name=cb-overlay-app-shell \
  --cap-add=SYS_ADMIN \
  --publish=8080:8080 \
  --publish=9090:9090 \
  --volume=${BASEDIR}/..:/src \
  --env=ACL_ENABLED=0 \
  --env=DEBUG="chaturbate:*" \
  paulallen87/chaturbate-overlay-app-shell