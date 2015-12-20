FROM circleci/ubuntu-server
ARG version 
USER ubuntu
ADD python_${version}_amd64.deb python_${version}_amd64.deb
RUN dpkg -I python_${version}_amd64.deb | grep Depends: | sed -e 's/Depends://g' | xargs sudo apt-get install
RUN sudo dpkg -i python_${version}_amd64.deb
# For some reason the string interpolocation doesn't work in my docker, so 'ENV PATH foo:$PATH' becomes 'foo:<empty>'
ENV PATH /opt/circleci/python/${version}/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
RUN python --version
