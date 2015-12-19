#!/bin/bash

set -e
set -x

version=$1

pushd src/
docker build --build-arg version=${version} -t kimh/python-build:${version} .
docker run kimh/python-build:${version} cat python_${version}_amd64.deb > python_${version}_amd64.deb
popd

pushd test/
cp ../src/python_${version}_amd64.deb .
docker build --no-cache --build-arg version=${version} -t kimh/python-test:${version} .
popd 
