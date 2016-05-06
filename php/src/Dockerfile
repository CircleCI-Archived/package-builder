FROM kimh/package_builder
ARG version
ARG package
ARG release
ARG install_dir
RUN mkdir -p ${install_dir}

ENV deps "libpng12-dev re2c m4 libxslt1-dev libjpeg-dev libxml2-dev libtidy-dev libmcrypt-dev libreadline-dev libmagic-dev libssl-dev libcurl4-openssl-dev libfreetype6-dev libapache2-mod-php5 libicu-dev apache2-dev autoconf"

RUN apt-get update && apt-get -y install $deps

RUN if [ ! -d "php-build" ]; then git clone git://github.com/php-build/php-build.git && cd php-build && ./install.sh; fi

# Enable pear support
RUN sed -i 's/--without-pear//' /usr/local/share/php-build/default_configure_options

# Create Apache module
# Prepending the line because otherwise php-build ignores the line (probably a bug of php-build)
RUN sed -i -e '1iwith_apxs2 "/usr/bin/apxs2"' /usr/local/share/php-build/definitions/*

# Enabling intl
# Customer request: https://discuss.circleci.com/t/ubuntu-trusty-has-no-pecl-support-under-php7/3700/10
RUN echo '--enable-intl' | tee -a /usr/local/share/php-build/default_configure_options

RUN php-build -i development ${version} ${install_dir}

RUN fpm -s dir -t deb -C ${install_dir} \
      --name circleci-${package}-${version} \
      --version ${release} \
      --prefix ${install_dir} \
      --force \
      --description "PHP ${version} built by CircleCI"  \
      $(echo $deps | sed 's/^/ /' | sed 's/ / -d /g') \
      .
