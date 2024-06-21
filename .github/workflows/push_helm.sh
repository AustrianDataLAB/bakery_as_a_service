#!/bin/bash

set -e

cd charts/baas || exit 1
echo "${REGISTRY_ACCESS_TOKEN}" | helm registry login -u ${REGISTRY_USERNAME} --password-stdin https://${REGISTRY}/${REPOSITORY_NAME}
helm dependency update .
helm lint .
helm package .
helm inspect chart *.tgz
helm push *.tgz oci://${REGISTRY}/${REPOSITORY_NAME}