FROM kimh/package_builder
ARG version
ARG prefix
ARG package
RUN mkdir -p ${prefix}/${package}/${version}

ENV deps "libpng12-dev re2c m4 libxslt1-dev libjpeg-dev libxml2-dev libtidy-dev libmcrypt-dev libreadline-dev libmagic-dev libssl-dev libcurl4-openssl-dev libfreetype6-dev libapache2-mod-php5 autoconf"

RUN apt-get -y install $deps

RUN git clone git://github.com/php-build/php-build.git && cd php-build && ./install.sh

RUN php-build ${version} ${prefix}/${package}/${version}

RUN fpm -s dir -t deb -C ${prefix}/${package}/${version} \
      --name circleci-${package}${version} \
      --version 0.0.1 \
      --prefix ${prefix}/${package}/${version} \
      --force \
      --description "PHP ${version} built by CircleCI"  \
      $(echo $deps | sed 's/^/ /' | sed 's/ / -d /g') \
      .
