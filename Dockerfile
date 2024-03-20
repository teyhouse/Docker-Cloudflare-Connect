FROM cgr.dev/chainguard/wolfi-base:latest@sha256:8b846d00ae9ef579801f7a44c19511187d9a9527ddeae2a6faedc6e9e035abec as build
LABEL maintainer="Tobias Thiel <administrator@nfeed.org>"

ARG CLOUDFLARED_VERSION=2024.3.0

RUN apk add --no-cache wget bash && \
    adduser -D -h /home/cloudflared cloudflared && \
    mkdir -p /home/cloudflared/.cloudflared && \
    chown -R cloudflared:cloudflared /home/cloudflared/.cloudflared

RUN \
    wget -q https://github.com/cloudflare/cloudflared/releases/download/${CLOUDFLARED_VERSION}/cloudflared-linux-amd64 -O /usr/bin/cloudflared && \
    chmod +x /usr/bin/cloudflared

USER cloudflared

FROM cgr.dev/chainguard/wolfi-base:latest@sha256:8b846d00ae9ef579801f7a44c19511187d9a9527ddeae2a6faedc6e9e035abec
COPY --from=build /home/cloudflared/.cloudflared /home/cloudflared/.cloudflared
COPY --from=build /etc/passwd /etc/passwd
COPY --from=build /usr/bin/cloudflared /usr/bin/cloudflared

USER cloudflared
WORKDIR /home/cloudflared/.cloudflared

HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
    CMD cloudflared --version || exit 1
    
ENTRYPOINT ["cloudflared", "tunnel", "run"]