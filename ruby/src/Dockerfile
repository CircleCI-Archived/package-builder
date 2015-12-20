FROM circleci/ubuntu-server
ARG version
ARG prefix
ARG package
RUN apt-get update
RUN apt-get -y install ruby-dev build-essential git
RUN gem install fpm
RUN mkdir -p ${prefix}/${package}/${version}

## Ruby configure options and build dependencies
ENV deps "autoconf bison libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev zlib1g-dev"
ENV RUBY_CONFIGURE_OPTS "--disable-install-doc"

RUN apt-get -y install $deps

RUN git clone https://github.com/rbenv/ruby-build.git && cd ruby-build && ./install.sh

RUN ruby-build ${version} ${prefix}/${package}/${version}

RUN ${prefix}/${package}/${version}/bin/gem install bundler

RUN fpm -s dir -t deb -C ${prefix}/${package}/${version} \
      --name circleci-${package}${version} \
      --version 0.0.1 \
      --prefix ${prefix}/${package}/${version} \
      --force \
      --description "Ruby ${version} built by CircleCI"  \
      $(echo $deps | sed 's/^/ /' | sed 's/ / -d /g') \
      .
