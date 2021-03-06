![Monero Logo](https://web.getmonero.org/img/monero-logo.png)

# Monero Miner with Docker Alpine


Image of latest [xmrig](https://github.com/xmrig/xmrig) version, built on Alpine.


## Run

For easy start, with default configuration.

```sh
docker run -d --restart=always sztes/monero-miner-docker
```

Use your own configuration.

- Create your [wallet](https://mymonero.com/)
- Choose a [pool](http://moneropools.com/) (default: `xmrvsbeast.com:4242` with 0% pool fee)
- Run container

```sh
docker run -d -e WALLET="{YOUR_WALLET_ID}" sztes/monero-miner-docker
```

|Environment       |     Description      |
|------------------|----------------------|
|WALLET            | Wallet Address       |
|POOL              | URL of mining server |

**Advanced**

You can customize [xmrig options](https://github.com/xmrig/xmrig#command-line-options).
```sh
docker run -d gsztes/monero-miner-docker xmrig\
     -o pool.supportxmr.com:3333 \
     -u <YOUR_WALLET> \
     -k  \
     --cpu-priority=2
```

### Management
To manage your docker images and containers on web GUI use the portaniner

$ docker run -d -p 9000:9000 --restart always -v /var/run/docker.sock:/var/run/docker.sock -v /opt/portainer:/data portainer/portainer

#### If you would like donate me, i will very appreciate it.

- XMR: `49v2z6BwRvSDfJEQcWbb3cRaGsNZpLWW5EWDDDU7N5xmGfxFC7YkBNDbAivEboQ5dLRBpNnaucKJDbSMdAwfH6gTVBrJrna`
- BTC: `bc1qs6z7w8jgympnmcc9w53kvfq64hv2ct8r293z0y`
