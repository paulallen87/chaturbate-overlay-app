#!/bin/bash

docker rm -f cb-overlay-app

docker run \
  -ti \
  --name=cb-overlay-app \
  --cap-add=SYS_ADMIN \
  --publish=8080:8080 \
  paulallen87/chaturbate-overlay-app