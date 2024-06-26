ARG BASE
ARG CPANOUTDATED
FROM perl:${BASE}

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

COPY cpanfile /tmp/

RUN perl -V

RUN apt-get update && \
        apt-get dist-upgrade -y && \
        apt-get -y --no-install-recommends install \
            aspell aspell-en \
            build-essential \
            git

RUN cpanm --self-upgrade || \
    ( echo "# Installing cpanminus:"; curl -sL https://cpanmin.us/ | perl - App::cpanminus )

RUN cpanm -nq App::cpm Carton::Snapshot && rm -rf /root/.cpanm

RUN cpm install -g --show-build-log-on-failure --cpanfile /tmp/cpanfile && rm -rf /root/.perl-cpm

RUN if [ "x${CPANOUTDATED}" = "x1" ] ; then cpan-outdated --exclude-core -p | xargs -n1 cpanm ; else cpan-outdated --exclude-core -p; fi

WORKDIR /tmp/
RUN git clone https://github.com/perl-actions/ci-perl-tester-helpers.git --depth 1 && \
    cp ci-perl-tester-helpers/bin/* /usr/local/bin/ && \
    rm -rf ci-perl-tester-helpers && \
    git config --system --add safe.directory '*'

CMD ["/bin/bash"]
