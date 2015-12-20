FROM circleci/ubuntu-server
ARG version
RUN apt-get update
RUN apt-get -y install ruby-dev build-essential git
RUN gem install fpm
RUN mkdir -p /opt/circleci/python/${version}

## Python configure options and build dependencies
ENV CONFIGURE_OPTS "--enable-unicode=ucs4"
RUN apt-get install -y zlib1g-dev libreadline-dev libsqlite3-dev libgdbm-dev libssl-dev libbz2-dev

RUN git clone git://github.com/yyuu/pyenv.git && cd pyenv/plugins/python-build && ./install.sh

RUN curl -k -L -O https://www.python.org/ftp/python/${version}/Python-${version}.tgz && \
    tar zxvf Python-${version}.tgz

RUN python-build ${version} /opt/circleci/python/${version}

RUN fpm -s dir -t deb -C /opt/circleci/python/${version} \
      --name python \
      --version ${version} \
      --prefix /opt/circleci/python/${version} \
      --force \
      --description "Python ${version} built by CircleCI"  \
      .
 