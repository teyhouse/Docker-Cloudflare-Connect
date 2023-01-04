FROM ubuntu:lunar

LABEL maintainer="Tobias Thiel <administrator@nfeed.org>"

ARG CLOUDFLARED_VERSION=2022.12.1
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends wget bash ca-certificates && \
    rm -rf /var/lib/apt/lists/*

RUN ARCH="" && \
    case $(uname -m) in \
        x86_64) ARCH="amd64" ;; \
        aarch64) ARCH="arm64" ;; \
        *) echo "Unknown build architecture $(uname -m), quitting."; exit 2 ;; \
    esac && \
    wget -q https://github.com/cloudflare/cloudflared/releases/download/${CLOUDFLARED_VERSION:-../latest/download}/cloudflared-linux-${ARCH}.deb && \
    dpkg -i cloudflared-linux-${ARCH}.deb && \
    rm cloudflared-linux-${ARCH}.deb && \
    cloudflared --version

RUN mkdir /root/.cloudflared
WORKDIR /root/.cloudflared
ENTRYPOINT ["cloudflared", "tunnel", "run"]
#ENTRYPOINT ["tail", "-f", "/dev/null"]