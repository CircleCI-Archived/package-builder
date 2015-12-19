FROM circleci/ubuntu-server
ARG version 
USER ubuntu
ADD python_${version}_amd64.deb python_${version}_amd64.deb
RUN dpkg -I python_${version}_amd64.deb | grep Depends: | sed -e 's/Depends://g' | xargs sudo apt-get install
RUN sudo dpkg -i python_${version}_amd64.deb

