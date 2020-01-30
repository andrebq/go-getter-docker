#!/usr/bin/env bash
set -euo pipefail

declare tagname
tagname=$(git tag -l --points-at HEAD | head -n 1)
readonly tagname

function push {
    declare -r imageName="andrebq/go-getter:${tagname}"
    docker tag "andrebq/go-getter:latest" "${imageName}"
    docker push "${imageName}"
}

push
