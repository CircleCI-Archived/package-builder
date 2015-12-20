FROM circleci/ubuntu-server
ARG version 
ENV deb circleci-ruby${version}_0.0.1_amd64.deb
ADD $deb $deb
RUN apt-get update
RUN apt-get install -y build-essential
RUN dpkg -I $deb | grep Depends: | sed -e 's/Depends://g' | sed -e 's/,//g' | xargs apt-get -y install
RUN sudo dpkg -i $deb
ENV RUBYLIB /opt/circleci/ruby/${version}/lib/ruby/2.2.0:/opt/circleci/ruby/${version}/lib/ruby/2.2.0/x86_64-linux
# For some reason the string interpolocation doesn't work in my docker, so 'ENV PATH foo:$PATH' becomes 'foo:<empty>'
ENV PATH /opt/circleci/ruby/${version}/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
RUN ruby --version
RUN gem --version
RUN gem install bundler
RUN bundle init && echo "gem 'rails'" >> Gemfile && bundle install && bundle exec rails --version