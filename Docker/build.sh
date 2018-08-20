#!/usr/bin/env sh
if [ -z "$1" ]; then
  $1 = 'master'
fi
docker build --build-arg branch=$1 . -t eosio/eos
docker run --name nodeos -d --rm -t eosio/eos /bin/bash
docker cp nodeos:/opt/eosio/bin/nodeos .
docker cp nodeos:/opt/eosio/bin/cleos .
docker stop nodeos
