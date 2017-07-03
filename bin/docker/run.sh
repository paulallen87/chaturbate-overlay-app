#!/bin/bash

cd $(dirname "${0}")
BASEDIR=$(pwd -L)
cd -

docker rm -f cb-overlay-app

docker run \
  -ti \
  --name=cb-overlay-app \
  --cap-add=SYS_ADMIN \
  --publish=8080:8080 \
  --publish=9090:9090 \
  --volume=${BASEDIR}/../../certs:/build/certs \
  paulallen87/chaturbate-overlay-app