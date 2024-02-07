FROM caddy:builder AS builder

RUN <<EOF
xcaddy build \
    --with github.com/caddy-dns/gandi
EOF

FROM caddy:latest

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
