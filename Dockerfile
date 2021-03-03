FROM alpine:3.13 AS builder

ARG XMRIG_VERSION='v6.9.0'
WORKDIR /miner

RUN echo "@community http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    apk update && apk add --no-cache \
    build-base \
    git \
    cmake \
    libuv-dev \
    libressl-dev \ 
    hwloc-dev@community

RUN git clone https://github.com/xmrig/xmrig && \
    mkdir xmrig/build && \
    cd xmrig && git checkout ${XMRIG_VERSION}

COPY build.patch /miner/xmrig
RUN cd xmrig && git apply build.patch

RUN cd xmrig/build && \
    cmake .. -DCMAKE_BUILD_TYPE=Release && \
    make -j$(nproc)


FROM alpine:3.13
LABEL owner="Giancarlos Salas"
LABEL maintainer="giansalex@gmail.com"

ENV WALLET=49v2z6BwRvSDfJEQcWbb3cRaGsNZpLWW5EWDDDU7N5xmGfxFC7YkBNDbAivEboQ5dLRBpNnaucKJDbSMdAwfH6gTVBrJrna
ENV POOL=pool.supportxmr.com:5555

RUN echo "@community http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    apk update && apk add --no-cache \
    libuv \
    libressl \ 
    hwloc@community

WORKDIR /xmr
COPY --from=builder /miner/xmrig/build/xmrig /xmr

CMD ["sh", "-c", "./xmrig --url=$POOL --donate-level=3 --user=$WALLET --pass=docker -k --coin=monero"]
