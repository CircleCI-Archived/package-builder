FROM circleci/ubuntu-server
ARG version
RUN apt-get update
RUN apt-get -y install ruby-dev build-essential git
RUN gem install fpm
RUN mkdir -p /opt/circleci/python/${version}

## Python configure options and build dependencies
ENV deps "zlib1g-dev libreadline-dev libsqlite3-dev libgdbm-dev libssl-dev libbz2-dev"
ENV CONFIGURE_OPTS "--enable-unicode=ucs4"

RUN apt-get -y install $deps

RUN git clone git://github.com/yyuu/pyenv.git && cd pyenv/plugins/python-build && ./install.sh

RUN python-build ${version} /opt/circleci/python/${version}

RUN /opt/circleci/python/${version}/bin/pip install nose pep8

RUN fpm -s dir -t deb -C /opt/circleci/python/${version} \
      --name circleci-python${version} \
      --version 0.0.1 \
      --prefix /opt/circleci/python/${version} \
      --force \
      --description "Python ${version} built by CircleCI" \
      $(echo $deps | sed 's/^/ /' | sed 's/ / -d /g') \
      .
 