# Design Goals
- Separation between packaging building and image creation
- Making package information open to users
- Automation

# Package Repository
https://packagecloud.io/circleci/circleci

# How to use
To build a new package, you first need to create directories and Dockerfiles.

Ex. python :

```
./python
  src/
    Dockerfile
  test/
    Dockerfile
```

The `src/Dockerfile` is used to build a package. Optionally you can create `test/Dockerfile` to install the built package to do some testings.

Here is an example for `src/Dockerfile` to create ruby package.

`ruby/src/Dockerfile`

```
####### Don't change these lines!!
FROM circleci/ubuntu-server
ARG version
ARG prefix
ARG package
RUN apt-get update
RUN apt-get -y install ruby-dev build-essential git
RUN gem install fpm
RUN mkdir -p ${prefix}/${package}/${version}

####### Dependencies and config options to build a particular package
ENV deps "autoconf bison libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev zlib1g-dev"
ENV RUBY_CONFIGURE_OPTS "--disable-install-doc"

RUN apt-get -y install $deps

####### Actual commands for build. In ruby, we are using ruby-build and python-build for python and so on.
####### If no such **-build exists, you can install from source.
RUN git clone https://github.com/rbenv/ruby-build.git && cd ruby-build && ./install.sh

RUN ruby-build ${version} ${prefix}/${package}/${version}

####### You can install some nice-to-have things here
RUN ${prefix}/${package}/${version}/bin/gem install bundler

####### Packaging with fpm
RUN fpm -s dir -t deb -C ${prefix}/${package}/${version} \
      --name circleci-${package}${version} \
      --version 0.0.1 \
      --prefix ${prefix}/${package}/${version} \
      --force \
      --description "Ruby ${version} built by CircleCI"  \
      $(echo $deps | sed 's/^/ /' | sed 's/ / -d /g') \
      .
```

Once you created src/Dockerfile, you can run `build-package` script from the top directory.

```
./build-package ruby 2.2.2
```
