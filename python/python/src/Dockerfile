FROM circleci/ubuntu-server
ARG version
ARG pc_token
ENV PACKAGECLOUD_TOKEN $pc_token
RUN apt-get update
RUN apt-get -y install ruby-dev build-essential 
RUN gem install fpm package_cloud
RUN mkdir -p /opt/circleci
RUN curl -k -L -O https://www.python.org/ftp/python/${version}/Python-${version}.tgz && \
    tar zxvf Python-${version}.tgz

RUN cd Python-${version} && \
    ./configure \
      --prefix=/opt/circleci/python/${version} \
      --enable-unicode=ucs4 && \
    make && \
    make install

RUN fpm -s dir -t deb -C /opt/circleci/python/${version} \
      --name python \
      --version ${version} \
      #--depends libyaml-dev \
      --prefix /opt/circleci/python/${version} \
      --force \
      --description "Python ${version} built by CircleCI"  \
      .
