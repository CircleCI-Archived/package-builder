FROM circleci/ubuntu-server
ARG package
ARG version 
ENV deb circleci-${package}${version}_0.0.1_amd64.deb
ADD $deb $deb
RUN apt-get update
RUN apt-get install -y build-essential
RUN dpkg -I $deb | grep Depends: | sed -e 's/Depends://g' | sed -e 's/,//g' | xargs apt-get -y install
RUN sudo dpkg -i $deb
RUN php --version
