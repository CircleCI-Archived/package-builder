FROM kimh/package_builder
ARG version
ARG package
ARG release
ARG install_dir
RUN mkdir -p ${install_dir}

## Node configure options and build dependencies
ENV deps "zlib1g-dev libreadline-dev libsqlite3-dev libgdbm-dev libssl-dev libbz2-dev"
ENV CONFIGURE_OPTS "--enable-unicode=ucs4"
ENV PATH ${install_dir}/bin:$PATH

RUN apt-get update && apt-get -y install $deps

RUN if [ ! -d "node-build" ]; then git clone https://github.com/nodenv/node-build.git && cd node-build && ./install.sh; fi

RUN node-build ${version} ${install_dir}

RUN ${install_dir}/bin/npm config set ca "" --global
# npm 5.0.0 which is bundled with nodejs 8x has this issue when used in Docker: https://github.com/npm/npm/issues/16896
# Updating npm to the latest workaround this issue.
RUN if [ $(${install_dir}/bin/npm  --version) == "5.0.0" ]; then ${install_dir}/bin/npm install -g npm; fi
RUN ${install_dir}/bin/npm install -g coffee-script grunt bower grunt-cli nodeunit mocha

RUN fpm -s dir -t deb -C ${install_dir} \
      --name circleci-${package}-${version} \
      --version ${release} \
      --prefix ${install_dir} \
      --force \
      --description "Node ${version} built by CircleCI" \
      $(echo $deps | sed 's/^/ /' | sed 's/ / -d /g') \
      .
