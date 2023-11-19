FROM alpine:3.18.4

ARG VERSION=9.18.19-r0

RUN \
  apk add --no-cache \
    bind=${VERSION} \
    libcap-utils=2.69-r0 \
  && setcap CAP_NET_BIND_SERVICE=+eip /usr/sbin/named

EXPOSE 53

USER 100:101

ENTRYPOINT ["/usr/sbin/named"]

CMD ["-c", "/etc/bind/named.conf.authoritative", "-g"]
