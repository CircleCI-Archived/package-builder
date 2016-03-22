FROM kimh/package_builder
ARG version
ARG package
ARG release
ARG install_dir
RUN mkdir -p ${install_dir}

## Ruby configure options and build dependencies
ENV deps "autoconf bison libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev zlib1g-dev"
ENV RUBY_CONFIGURE_OPTS "--disable-install-doc"

RUN apt-get update && apt-get -y install $deps

RUN if [ ! -d "ruby-build" ]; then git clone https://github.com/rbenv/ruby-build.git && cd ruby-build && ./install.sh; fi

RUN ruby-build ${version} ${install_dir}

RUN ${install_dir}/bin/gem install bundler

RUN fpm -s dir -t deb -C ${install_dir} \
      --name circleci-${package}-${version} \
      --version ${release} \
      --prefix ${install_dir} \
      --force \
      --deb-compression xz \
      --description "Ruby ${version} built by CircleCI"  \
      $(echo $deps | sed 's/^/ /' | sed 's/ / -d /g') \
      .
