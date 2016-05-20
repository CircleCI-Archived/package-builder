FROM kimh/package_builder
ARG version
ARG package
ARG release
ARG install_dir
RUN mkdir -p ${install_dir}

ENV deps "libpng12-dev re2c m4 libxslt1-dev libjpeg-dev libxml2-dev libtidy-dev libmcrypt-dev libreadline-dev libmagic-dev libssl-dev libcurl4-openssl-dev libfreetype6-dev libapache2-mod-php5 libicu-dev apache2-dev autoconf"

RUN apt-get update && apt-get -y install $deps

RUN if [ ! -d "php-build" ]; then git clone git://github.com/php-build/php-build.git && cd php-build && ./install.sh; fi

RUN apt-get install -y libbz2-dev libgmp3-dev

# For --with-gmp to find gmp.h
RUN ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/include/gmp.h

RUN echo " \n\
--with-libdir=lib/x86_64-linux-gnu/ \n\
--with-gmp \n\
--with-pdo-pgsql \n\
--with-ldap \n\
--enable-calendar \n\
--enable-bcmath \n\
--with-bz2 \n\
--enable-zip \n\
--with-exif \n\
--with-gd \n\
--with-gettext \n\
--enable-intl \n\
--enable-phar \n\
--with-pear \n\
--enable-zip \n\
--with-curl=/usr/local \n\
--with-mcrypt=/usr/local \n\
--with-xsl=/usr/local \n\
--with-png-dir=/usr/local \n\
--with-jpeg-dir=/usr/local \n\
--with-readline \n\
--with-freetype-dir=/usr/include/freetype2 \n\
--with-gettext=/usr/bin \n\
" >> /usr/local/share/php-build/default_configure_options

# Create Apache module
# Prepending the line because otherwise php-build ignores the line (probably a bug of php-build)
RUN sed -i -e '1iwith_apxs2 "/usr/bin/apxs2"' /usr/local/share/php-build/definitions/*

RUN php-build -i development ${version} ${install_dir}

RUN fpm -s dir -t deb -C ${install_dir} \
      --name circleci-${package}-${version} \
      --version ${release} \
      --prefix ${install_dir} \
      --force \
      --description "PHP ${version} built by CircleCI"  \
      $(echo $deps | sed 's/^/ /' | sed 's/ / -d /g') \
      .
