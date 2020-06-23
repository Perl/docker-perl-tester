ARG BASE
FROM perl:${BASE}

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

COPY cpanfile /tmp/

RUN perl -V

RUN apt-get update && \
        apt-get dist-upgrade -y && \
        apt-get -y --no-install-recommends install aspell aspell-en

RUN cpanm --self-upgrade || \
    ( echo "# Installing cpanminus:"; curl -sL https://cpanmin.us/ | perl - App::cpanminus )

RUN cpanm -nq App::cpm Carton::Snapshot

RUN cpm install -g --show-build-log-on-failure --cpanfile /tmp/cpanfile

RUN cpan-outdated --exclude-core -p | xargs -n1 cpanm

WORKDIR /tmp/
RUN git clone https://github.com/oalders/ci-perl-tester-helpers.git --depth 1 && \
    cp ci-perl-tester-helpers/bin/* /usr/local/bin/ && \
    rm -rf ci-perl-tester-helpers

CMD ["/bin/bash"]
