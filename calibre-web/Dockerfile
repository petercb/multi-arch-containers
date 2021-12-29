FROM pypy:3.8-7.3.7-slim-bullseye AS builder

ARG VERSION=0.6.14

# hadolint ignore=DL3008
RUN \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        g++ \
        gcc \
        libffi-dev \
        libjpeg-dev \
        libldap2-dev \
        libsasl2-dev \
        libxml2-dev \
        libxslt1-dev \
        zlib1g-dev

USER 1000

WORKDIR /app

RUN python3 -m venv /app && \
    /app/bin/pip3 install --no-cache-dir calibreweb==${VERSION}


FROM pypy:3.8-7.3.7-slim-bullseye AS runtime

COPY --from=builder /app /app

RUN adduser --home /app/home --uid 1000 cps

USER 1000

WORKDIR /config

ENV CALIBRE_DBPATH=/config
ENV CALIBRE_PORT=8083

EXPOSE 8083

ENTRYPOINT [ "/app/bin/cps" ]
