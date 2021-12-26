FROM alpine:3.15.0

ARG VERSION=9.16.22-r4

RUN \
    apk update && \
    apk search bind && \
    apk add --no-cache bind=${VERSION} && \
    rm -rf /var/cache/apk/*

EXPOSE 53

USER 100:101

ENTRYPOINT ["/usr/sbin/named"]

CMD ["-c", "/etc/bind/named.conf.authoritative", "-g"]
