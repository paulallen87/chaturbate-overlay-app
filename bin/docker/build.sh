#!/bin/bash

cd $(dirname "${0}")
BASEDIR=$(pwd -L)
cd ../..

docker build --tag paulallen87/chaturbate-overlay-app .