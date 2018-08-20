#!/usr/bin/env sh
docker pull eosar/eos:$1
docker tag eosar/eos:$1 eosio/eos
docker run --name nodeos -d --rm -t eosio/eos /bin/bash
docker cp nodeos:/opt/eosio/bin/nodeos .
docker cp nodeos:/opt/eosio/bin/cleos .
docker stop nodeos
