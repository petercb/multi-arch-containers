#!/bin/bash

set -e
set -u

function cleanup {
    echo "Stopping builder"
    docker buildx stop container
}

trap cleanup EXIT

docker buildx create --driver docker-container --name container --node container0 --use
docker run --privileged --rm tonistiigi/binfmt --install all

for dockerfile in ${1:-*}/Dockerfile
do
    image="$(dirname ${dockerfile})"
    pushd "${image}"
    docker buildx build --builder container --load --platform linux/amd64 -t petercb/${image}:latest .
    container-structure-test test --config container-structure-test.yaml --image petercb/${image}:latest
    docker buildx build --builder container --platform linux/arm64/v8 -t petercb/${image}:latest .
    popd
done
