FROM circleci/ubuntu-server
ARG version 
USER ubuntu
ADD ruby_${version}_amd64.deb ruby_${version}_amd64.deb
RUN sudo dpkg -i ruby_${version}_amd64.deb
ENV RUBYLIB /opt/circleci/ruby/${version}/lib/ruby/2.2.0:/opt/circleci/ruby/${version}/lib/ruby/2.2.0/x86_64-linux
# For some reason the string interpolocation doesn't work in my docker, so 'ENV PATH foo:$PATH' becomes 'foo:<empty>'
ENV PATH /opt/circleci/ruby/${version}/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
RUN ruby --version
RUN gem --version

