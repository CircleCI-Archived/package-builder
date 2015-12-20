FROM circleci/ubuntu-server
ARG version 
USER ubuntu
ENV deb circleci_ruby${version}_v0.0.1_amd64.deb
ADD $deb $deb
RUN sudo dpkg -i $deb
# For some reason the string interpolocation doesn't work in my docker, so 'ENV PATH foo:$PATH' becomes 'foo:<empty>'
ENV PATH /opt/circleci/python/${version}/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
RUN python --version
