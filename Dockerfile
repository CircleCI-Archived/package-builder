FROM circleci/ubuntu-server
ARG version
ARG package
ARG install_dir
RUN apt-get update
RUN apt-get -y install ruby-dev build-essential git
RUN gem install fpm