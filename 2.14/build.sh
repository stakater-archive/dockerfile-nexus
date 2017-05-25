#!/bin/bash
_nexus_version=$1
_nexus_tag=$2
_release_build=false

if [ -z "${_nexus_version}" ]; then
	source NEXUS_VERSION
	_nexus_version=$NEXUS_VERSION
	_nexus_tag=$NEXUS_VERSION
	_release_build=true
fi

echo "NEXUS_VERSION: ${_nexus_version}"
echo "DOCKER TAG: ${_nexus_tag}"
echo "RELEASE BUILD: ${_release_build}"

docker build --build-arg NEXUS_VERSION=${_nexus_version} --tag "stakater/nexus:${_nexus_tag}"  --no-cache=true .

if [ $_release_build == true ]; then
	docker tag "stakater/nexus:${_nexus_tag}" "stakater/nexus:latest"
fi