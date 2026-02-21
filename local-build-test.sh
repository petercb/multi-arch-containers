#!/bin/bash

set -eu

export DOCKER_BUILDKIT=1
export BUILDKIT_PROGRESS=plain

PLATFORMS=("linux/aarch64" "linux/amd64")

for dockerfile in ${1:-*}/Dockerfile
do
    image="$(dirname ${dockerfile})"
    pushd "${image}"
    if [ -f build-env.sh ]; then
        source build-env.sh
    fi

    for platform in "${PLATFORMS[@]}"; do
        echo "Building ${image} for ${platform}"
        docker build \
            --tag "petercb/${image}:latest" \
            --platform "${platform}" \
            --file Dockerfile \
            .
        container-structure-test test \
            --platform "${platform}" \
            --config container-structure-test.yaml \
            --image "petercb/${image}:latest"
    done
    popd
done
