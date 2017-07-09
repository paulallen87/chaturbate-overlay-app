#!/bin/bash

cd $(dirname "${0}")
BASEDIR=$(pwd -L)
cd -

docker rm -f cb-overlay-app

docker run \
  -ti \
  --name=cb-overlay-app \
  --publish=8080:8080 \
  --publish=9090:9090 \
  --volume=${BASEDIR}/../../certs:/build/certs \
  --volume=${BASEDIR}/../../config:/build/config \
  --env=ACL_ENABLED=0 \
  --env=DEBUG="chaturbate:*" \
  paulallen87/chaturbate-overlay-app