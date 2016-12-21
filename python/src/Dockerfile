FROM kimh/package_builder
ARG version
ARG package
ARG release
ARG install_dir
RUN mkdir -p ${install_dir}

## Python configure options and build dependencies
ENV deps "zlib1g-dev libreadline-dev libsqlite3-dev libgdbm-dev libssl-dev libbz2-dev libncurses5 libncurses5-dev libncursesw5"
ENV CONFIGURE_OPTS "--enable-unicode=ucs4"

RUN apt-get update && apt-get -y install $deps

RUN if [ ! -d "pyenv" ]; then git clone git://github.com/yyuu/pyenv.git  && cd pyenv/plugins/python-build && ./install.sh; fi

RUN python-build ${version} ${install_dir}

RUN ${install_dir}/bin/pip install nose pep8 virtualenv

RUN fpm -s dir -t deb -C ${install_dir} \
      --name circleci-${package}-${version} \
      --version ${release} \
      --prefix ${install_dir} \
      --force \
      --description "Python ${version} built by CircleCI" \
      $(echo $deps | sed 's/^/ /' | sed 's/ / -d /g') \
      .
