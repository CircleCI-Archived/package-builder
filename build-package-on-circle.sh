#!/bin/bash

set -e

pkg_dir=/opt/circleci

python_release=2
python_versions="
2.6.9 \
2.7.6 \
2.7.9 \
2.7.10 \
2.7.11 \
2.7.12 \
2.7.13 \
3.1.3 \
3.1.4 \
3.1.5 \
3.2.4 \
3.2.5 \
3.2.6 \
3.3.4 \
3.3.5 \
3.3.6 \
3.4.2 \
3.4.3 \
3.4.4 \
3.4.5 \
3.4.6 \
3.5.0 \
3.5.1 \
3.5.2 \
3.5.3 \
3.6.0 \
3.6.1 \
3.6.2 \
3.6.3 \
pypy-1.9 \
pypy-2.6.1 \
pypy-4.0.1 \
pypy-5.1.1 \
pypy-5.3.1 \
"

ruby_release=1
ruby_versions="
2.0.0-p647 \
2.1.6 \
2.1.7 \
2.1.8 \
2.1.9 \
2.2.2 \
2.2.3 \
2.2.4 \
2.2.5 \
2.2.6 \
2.2.7 \
2.3.0 \
2.3.1 \
2.3.2 \
2.3.3 \
2.3.4 \
2.3.5 \
2.4.0 \
2.4.1 \
2.4.2 \
"

php_release=5
php_versions="
5.5.31 \
5.5.32 \
5.5.33 \
5.5.34 \
5.5.35 \
5.6.16 \
5.6.17 \
5.6.18 \
5.6.19 \
5.6.20 \
5.6.21 \
5.6.22 \
5.6.23 \
7.0.1 \
7.0.2 \
7.0.3 \
7.0.4 \
7.0.5 \
7.0.6 \
7.0.7 \
7.0.8 \
7.0.9 \
7.0.10 \
7.0.11 \
7.0.12 \
7.0.13 \
7.0.14 \
7.0.15 \
7.0.16 \
7.0.17 \
7.0.18 \
7.0.19 \
7.0.20 \
7.0.21 \
7.0.22 \
7.0.23 \
7.0.24 \
7.1.0 \
7.1.1 \
7.1.2 \
7.1.3 \
7.1.4 \
7.1.5 \
7.1.6 \
7.1.7 \
7.1.8 \
7.1.9 \
"

nodejs_release=1
nodejs_versions="
0.12.9 \
4.0.0 \
4.1.2 \
4.2.6 \
4.3.0 \
4.5.0 \
5.0.0 \
5.1.1 \
5.2.0 \
5.3.0 \
5.4.1 \
5.5.0 \
5.6.0 \
5.7.0 \
5.8.0 \
5.9.0 \
5.10.0 \
5.10.1 \
5.11.1 \
5.12.0 \
6.1.0 \
6.2.0 \
6.2.1 \
6.2.2 \
6.3.0 \
6.3.1 \
6.4.0 \
6.5.0 \
6.6.0 \
6.7.0 \
6.8.0 \
6.8.1 \
6.9.0 \
6.9.1 \
6.9.2 \
6.11.4 \
7.0.0 \
7.1.0 \
7.2.0 \
7.2.1 \
7.3.0 \
8.0.0 \
8.1.0 \
8.1.1 \
8.1.2 \
8.1.3 \
8.1.4 \
8.2.0 \
8.6.0 \
"

function version_exists() {
    curl -s https://$PACKAGECLOUD_TOKEN:@packagecloud.io/api/v1/repos/circleci/trusty/package/deb/ubuntu/trusty/circleci-$1-$2/amd64/$3.json | jq  --exit-status '. | length != 0'
}

function push_pkg() {
    package_cloud push circleci/trusty/ubuntu/trusty $1
}

function build_package() {
    local package=$1
    local version=$2
    local release=$3
    local deb=$package/circleci-${package}-${version}_${release}_amd64.deb

    case $package in
	ruby)
	    local install_dir=$pkg_dir/ruby/ruby-$version;
	    ;;
	python)
	    local install_dir=$pkg_dir/python/$version;
	    ;;
	php)
	    local install_dir=$pkg_dir/php/$version;
	    ;;
	nodejs)
	    local install_dir=$pkg_dir/nodejs/v$version; # Watch out, 'v' is there!
	    ;;
	*)
	    echo "unknown package: $package";
	    exit 0;
	    ;;
    esac

    if version_exists $package $version $release; then
	echo "$package:$version:$release already exists. Skip building."
    else
	./build-package $package $version $release $install_dir
	push_pkg $deb
    fi
}

case $CIRCLE_NODE_INDEX in
    0)
        for v in $python_versions; do
            build_package python $v $python_release
        done
        ;;
    1)
        for v in $ruby_versions; do
            build_package ruby $v $ruby_release
        done
        ;;
    2)
        for v in $php_versions; do
            build_package php $v $php_release
        done
        ;;
    3)
        for v in $nodejs_versions; do
            build_package nodejs $v $nodejs_release
        done
        ;;
    *)
        exit 0;
        ;;
esac
