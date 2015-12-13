#!/bin/bash

set -e
set -x

version=$1

pushd src/
docker build --build-arg version=${version} -t kimh/ruby-build:${version} .
docker run kimh/ruby-build:${version} cat ruby_${version}_amd64.deb > ruby_${version}_amd64.deb
popd

pushd test/
cp ../src/ruby_${version}_amd64.deb .
docker build --no-cache --build-arg version=${version} .
popd 
