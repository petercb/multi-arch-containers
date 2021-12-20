FROM golang:1.16 AS builder

ARG TARGETARCH
ARG TARGETVARIANT
ARG VERSION=0.10.2

ADD https://github.com/kubernetes-sigs/external-dns/archive/refs/tags/v${VERSION}.tar.gz /tmp/external-dns.tar.gz

RUN \
    tar xf /tmp/external-dns.tar.gz && \
    make -C external-dns-${VERSION} test build.${TARGETARCH}${TARGETVARIANT} && \
    mv external-dns-${VERSION}/build/external-dns /tmp/external-dns

FROM alpine:3.15.0 AS runtime

COPY --from=builder /tmp/external-dns /bin/external-dns

# Run as UID for nobody since k8s pod securityContext runAsNonRoot can't resolve the user ID:
# https://github.com/kubernetes/kubernetes/issues/40958
USER 65534

ENTRYPOINT ["/bin/external-dns"]
