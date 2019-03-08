#!/bin/bash

set -eu

source ./.env

git clone https://github.com/crowi/crowi.git
sed -e 's/3000:3000/${CROWI_PORT}:3000/g' crowi/docker-compose.development.yml > crowi/docker-compose.mod.yml

## 作らないとroot ownerでディレクトリが作られてアクセスできなくなる。
mkdir -p crowi/data/elasticsearch

docker-compose -f crowi/docker-compose.mod.yml build
docker-compose -f crowi/docker-compose.mod.yml up -d
