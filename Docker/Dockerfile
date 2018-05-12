FROM eosio/builder as builder

ARG origin=EOSArgentina
ARG branch=aurora
ARG tag
ARG symbol=EOS

RUN git config --global user.email "you@example.com" && \
    git config --global user.name "Name" && \
    git clone -b $branch https://github.com/$origin/eos.git && \
    cd eos && \
    git remote add eosio https://github.com/EOSIO/eos.git && \
    git fetch eosio master && \
    git rebase eosio/master && \
    git checkout $tag && \
    git submodule update --init --recursive

WORKDIR /eos
RUN echo "$branch:$(git rev-parse HEAD)" > /etc/eosio-version && \
    cmake -j16 -H. -B"/tmp/build" -GNinja -DCMAKE_BUILD_TYPE=Release \
      -DWASM_ROOT=/opt/wasm -DCMAKE_CXX_COMPILER=clang++ -DCORE_SYMBOL_NAME=$symbol \
      -DCMAKE_C_COMPILER=clang -DCMAKE_INSTALL_PREFIX=/tmp/build \
      -DSecp256k1_ROOT_DIR=/usr/local -DBUILD_MONGO_DB_PLUGIN=true && \
    cmake --build /tmp/build --target install && rm /tmp/build/bin/eosiocpp

FROM ubuntu:18.04

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install openssl && rm -rf /var/lib/apt/lists/*
COPY --from=builder /usr/local/lib/* /usr/local/lib/
COPY --from=builder /tmp/build/bin /opt/eosio/bin
COPY --from=builder /tmp/build/contracts /contracts
COPY --from=builder /eos/Docker/config.ini /
COPY --from=builder /etc/eosio-version /etc
COPY --from=builder /eos/Docker/nodeosd.sh /opt/eosio/bin/nodeosd.sh
ENV EOSIO_ROOT=/opt/eosio
RUN chmod +x /opt/eosio/bin/nodeosd.sh
ENV LD_LIBRARY_PATH /usr/local/lib
VOLUME /opt/eosio/bin/data-dir
ENV PATH /opt/eosio/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
