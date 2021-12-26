FROM alpine:3.15.0 AS build

ARG VERSION=2.1.2

WORKDIR /app/ubooquity

ADD http://vaemendis.net/ubooquity/downloads/Ubooquity-${VERSION}.zip ubooquity.zip

# hadolint ignore=DL3018
RUN \
    apk add --no-cache unzip && \
    unzip ubooquity.zip && \
    rm ubooquity.zip

FROM alpine:3.15.0 AS runtime

COPY --from=build /app /app

# hadolint ignore=DL3018
RUN apk add --no-cache openjdk10-jre-headless

EXPOSE 2202 2203

USER 1000

WORKDIR /books
WORKDIR /files
WORKDIR /comics

WORKDIR /config

ENTRYPOINT [ "java", "-jar", "/app/ubooquity/Ubooquity.jar" ]
CMD ["--headless", "--host", "0.0.0.0", "--remoteadmin", "--workdir", "/config"]
