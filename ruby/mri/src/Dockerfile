FROM circleci/ubuntu-server
ARG version
RUN apt-get update
RUN apt-get -y install ruby-dev build-essential
RUN gem install fpm
RUN mkdir -p /opt/circleci
RUN curl -k -L -O https://ftp.ruby-lang.org/pub/ruby/ruby-${version}.tar.gz && \
    tar zxvf ruby-${version}.tar.gz

RUN cd ruby-${version} && \
    ./configure \
      --prefix=/opt/circleci/ruby/${version} \
      --disable-install-doc && \
    make && \
    make install

RUN fpm -s dir -t deb -C /opt/circleci/ruby/${version} \
      --name ruby \
      --version ${version} \
      --depends libyaml-dev \
      --prefix /opt/circleci/ruby/${version} \
      --force \
      --description "Ruby ${version} built by CircleCI"  \
      .
