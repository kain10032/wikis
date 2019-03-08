#!/bin/bash

set -eu

source ./.env

git clone https://github.com/weseek/growi-docker-compose.git
sed -e 's/127.0.0.1:3000:3000/${GROWI_PORT}:3000/g' growi-docker-compose/docker-compose.yml > growi-docker-compose/docker-compose.mod.yml
docker-compose -f growi-docker-compose/docker-compose.mod.yml build
docker-compose -f growi-docker-compose/docker-compose.mod.yml up -d
