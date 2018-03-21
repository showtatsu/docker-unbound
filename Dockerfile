FROM alpine:latest
MAINTAINER show.tatsu.devel@gmail.com

RUN apk update && \
    apk add --no-cache unbound && \
    mkdir -p /etc/unbound/conf.d && \
    chown -R unbound:unbound /etc/unbound && \
    wget -q -O /etc/unbound/root.hints "ftp://ftp.internic.net/domain/named.cache" && \
    unbound-anchor -a /etc/unbound/root.key ; true

COPY unbound.conf /etc/unbound/.
COPY conf.d /etc/unbound/conf.d/.

EXPOSE 53/udp 53/tcp

ENTRYPOINT ["/usr/sbin/unbound", "-dd", "-c", "/etc/unbound/unbound.conf"]
