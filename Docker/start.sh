#!/usr/bin/env sh
rm -rf /opt/eosio/bin/data-dir/blocks
rm -rf /opt/eosio/bin/data-dir/shared_mem
/opt/eosio/bin/nodeosd.sh --data-dir /opt/eosio/bin/data-dir --resync
