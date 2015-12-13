#!/bin/bash

set -e
set -x

version=$1

pushd src/
docker build --build-arg version=${version} -t kimh/ruby-build:${version} .
popd

docker run kimh/ruby-build:${version} cat ruby_${version}_amd64.deb > /tmp/ruby_${version}_amd64.deb

pushd test/
cp /tmp/ruby_${version}_amd64.deb . && docker build --no-cache --build-arg version=${version} .
popd 
