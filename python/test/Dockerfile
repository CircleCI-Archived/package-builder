FROM circleci/ubuntu-server
ARG version 
ENV deb circleci-python${version}_0.0.1_amd64.deb
ADD $deb $deb
RUN apt-get update
RUN apt-get install -y build-essential
RUN dpkg -I $deb | grep Depends: | sed -e 's/Depends://g' | sed -e 's/,//g' | xargs apt-get -y install
RUN sudo dpkg -i $deb
# For some reason the string interpolocation doesn't work in my docker, so 'ENV PATH foo:$PATH' becomes 'foo:<empty>'
ENV PATH /opt/circleci/python/${version}/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
RUN python --version
RUN pip --version
RUN nosetests --version
RUN pip install django

