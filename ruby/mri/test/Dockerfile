FROM circleci/ubuntu-server
ARG version 
USER ubuntu
ADD ruby_${version}_amd64.deb ruby_${version}_amd64.deb
RUN dpkg -I ruby_${version}_amd64.deb | grep Depends: | sed -e 's/Depends://g' | xargs sudo apt-get install
RUN sudo dpkg -i ruby_${version}_amd64.deb
ENV RUBYLIB /opt/circleci/ruby/${version}/lib/ruby/2.2.0:/opt/circleci/ruby/${version}/lib/ruby/2.2.0/x86_64-linux
ENV PATH /opt/circleci/ruby/${version}/bin:$PATH
RUN ruby --version
RUN gem --version

