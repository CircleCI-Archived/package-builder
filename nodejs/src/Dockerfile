FROM kimh/package_builder
ARG version
ARG package
ARG release
ARG install_dir
RUN mkdir -p ${install_dir}

## Node configure options and build dependencies
ENV deps "zlib1g-dev libreadline-dev libsqlite3-dev libgdbm-dev libssl-dev libbz2-dev"
ENV CONFIGURE_OPTS "--enable-unicode=ucs4"

RUN apt-get -y install $deps

RUN if [ ! -d "node-build" ]; then git clone https://github.com/nodenv/node-build.git && cd node-build && ./install.sh; fi

RUN node-build ${version} ${install_dir}

RUN ${install_dir}/bin/npm config set ca "" --global
RUN ${install_dir}/bin/npm install -g coffee-script grunt bower grunt-cli nodeunit mocha

RUN fpm -s dir -t deb -C ${install_dir} \
      --name circleci-${package}-${version} \
      --version ${release} \
      --prefix ${install_dir} \
      --force \
      --description "Node ${version} built by CircleCI" \
      $(echo $deps | sed 's/^/ /' | sed 's/ / -d /g') \
      .
