FROM alpine:3.19.1

ARG VERSION=4.18.9-r0

# hadolint ignore=DL3018
RUN apk --no-cache --no-progress add \
        bash \
        samba=${VERSION} \
        shadow \
        tini \
        tzdata && \
    addgroup -S smb && \
    adduser -S -D -H -h /tmp -s /sbin/nologin -G smb -g 'Samba User' smbuser

COPY smb.conf /etc/samba/
COPY samba.sh /usr/bin/

EXPOSE 137/udp 138/udp 139 445

HEALTHCHECK --interval=60s --timeout=15s CMD smbclient -L \\localhost -U % -m SMB3

VOLUME ["/etc", "/var/cache/samba", "/var/lib/samba", "/var/log/samba", "/run/samba"]

ENTRYPOINT ["/sbin/tini", "--", "/usr/bin/samba.sh"]
