#!/usr/bin/env sh
docker build --build-arg tag=$1 . -t eosio/eos
docker run --name nodeos -d --rm -t eosio/eos /bin/bash
docker cp nodeos:/opt/eosio/bin/nodeos .
docker cp nodeos:/opt/eosio/bin/cleos .
docker stop nodeos
