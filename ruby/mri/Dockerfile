FROM circleci/ubuntu-server
RUN apt-get update
RUN apt-get -y install ruby-dev build-essential
RUN gem install fpm
RUN mkdir -p /opt/circleci
RUN curl -L -O https://cache.ruby-lang.org/pub/ruby/2.2/ruby-2.2.3.tar.gz && \
    tar zxvf ruby-2.2.3.tar.gz && \
    cd ruby-2.2.3 && ./configure --prefix=/opt/circleci/ruby/2.2.3 && \
    make && \
    make install
RUN fpm -s dir -t deb -C /opt/circleci/ruby/2.2.3 --name ruby --version 2.2.3 --depends libyaml-dev --prefix /opt/circleci/ruby/2.2.3 -f --description "Ruby 2.2.3 built by CircleCI" .

## Installation Test
USER ubuntu
RUN sudo apt-get purge -y ruby1.9.1
RUN dpkg -I ruby_2.2.3_amd64.deb | grep Depends: | sed -e 's/Depends://g' | xargs sudo apt-get install
RUN sudo dpkg -i ruby_2.2.3_amd64.deb
ENV RUBYLIB /opt/circleci/ruby/2.2.3/lib/ruby/2.2.0:/opt/circleci/ruby/2.2.3/lib/ruby/2.2.0/x86_64-linux
ENV PATH /opt/circleci/ruby/2.2.3/bin:$PATH
RUN ruby --version
RUN gem --version
