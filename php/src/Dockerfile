FROM kimh/package_builder
ARG version
ARG package
ARG release
ARG install_dir
RUN mkdir -p ${install_dir}

ENV deps "libpng12-dev re2c m4 libxslt1-dev libjpeg-dev libxml2-dev libtidy-dev libmcrypt-dev libreadline-dev libmagic-dev libssl-dev libcurl4-openssl-dev libfreetype6-dev libapache2-mod-php5 apache2-threaded-dev autoconf"

RUN apt-get -y install $deps

RUN if [ ! -d "php-build" ]; then git clone git://github.com/php-build/php-build.git && cd php-build && ./install.sh; fi

RUN echo "--with-apxs2" >> /usr/local/share/php-build/default_configure_options

RUN php-build ${version} ${install_dir}

RUN mkdir -p ${install_dir}/libexec/apache2/ && cp /usr/lib/apache2/modules/libphp7.so ${install_dir}/libexec/apache2/

RUN fpm -s dir -t deb -C ${install_dir} \
      --name circleci-${package}-${version} \
      --version ${release} \
      --prefix ${install_dir} \
      --force \
      --description "PHP ${version} built by CircleCI"  \
      .
