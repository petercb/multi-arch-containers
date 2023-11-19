FROM alpine:3.18.4 AS build

ARG VERSION=4.2.0
ARG TARGETOS
ARG TARGETARCH
ARG TARGETVARIANT

ADD https://github.com/hacdias/webdav/releases/download/v${VERSION}/${TARGETOS}-${TARGETARCH}${TARGETVARIANT}-webdav.tar.gz /tmp/webdav.tar.gz

WORKDIR /app

RUN tar -xf /tmp/webdav.tar.gz

FROM alpine:3.18.4 AS runtime

COPY --from=build /app/webdav /webdav

# hadolint ignore=DL3018
RUN apk add --no-cache ca-certificates

EXPOSE 8888

USER 1000

ENV WD_PORT=8888

ENTRYPOINT [ "/webdav" ]
