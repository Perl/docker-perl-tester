ARG BASE
ARG CPANOUTDATED
FROM perl:${BASE}

# redefine after the FROM
ARG BASE
#ARG CPANOUTDATED
ENV BASE_IMAGE=${BASE}

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

COPY cpanfile /tmp/

RUN perl -V

RUN echo "DEBUG: BASE value is: ${BASE_IMAGE}" && \
    if echo "${BASE_IMAGE}" | grep -q "buster"; then \
        echo "DEBUG: BASE contains buster, updating sources.list"; \
        sed -i 's|http://deb.debian.org/debian|http://archive.debian.org/debian|g' /etc/apt/sources.list; \
        sed -i 's|http://security.debian.org/debian-security|http://archive.debian.org/debian-security|g' /etc/apt/sources.list; \
        echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/99no-check-valid-until; \
        echo "DEBUG: Archive sources configured successfully"; \
    else \
        echo "DEBUG: BASE does not contain buster, skipping archive configuration"; \
    fi

RUN apt-get update && \
        apt-get dist-upgrade -y && \
        apt-get -y --no-install-recommends install \
            aspell aspell-en \
            build-essential \
            gpg \
            git

RUN cpanm --self-upgrade || \
    ( echo "# Installing cpanminus:"; curl -sL https://cpanmin.us/ | perl - App::cpanminus )

RUN set -eux; \
    if perl -e 'exit(($^V ge v5.24.0) ? 0 : 1)'; then \
        cpanm -nq App::cpm Carton::Snapshot; \
    else \
        # App::cpm releases after 0.998003 require Perl >= 5.24 and the
        # 0.998003 CPAN release no longer installs on older Perls, so use
        # the self-contained (fatpacked) cpm script, which has no CPAN deps.
        # The commit SHA below is what tag 0.998003 points to, pinned so the
        # download is immutable; the checksum guards the script we run as root.
        # Note: only the cpm executable is installed here; App::cpm is not in
        # site_perl (downstream tooling only invokes the CLI).
        curl -fsSL --retry 3 https://raw.githubusercontent.com/skaji/cpm/1aa61b3c6c8aea2df7a8802206294d268422ccef/cpm -o /usr/local/bin/cpm; \
        echo '6a27e528cf37635773e738db36c4b4ab4345d5a9d00b8cbd2f2dc01abc73177d  /usr/local/bin/cpm' | sha256sum -c -; \
        chmod +x /usr/local/bin/cpm; \
        cpanm -nq Carton::Snapshot; \
    fi; \
    rm -rf /root/.cpanm; \
    cpm --version

RUN cpm install -g --show-build-log-on-failure --cpanfile /tmp/cpanfile && rm -rf /root/.perl-cpm

RUN if [ "x${CPANOUTDATED}" = "x1" ] ; then cpan-outdated --exclude-core -p | xargs -n1 cpanm ; else cpan-outdated --exclude-core -p; fi

WORKDIR /tmp/
RUN git clone https://github.com/perl-actions/ci-perl-tester-helpers.git --depth 1 && \
    cp ci-perl-tester-helpers/bin/* /usr/local/bin/ && \
    rm -rf ci-perl-tester-helpers && \
    git config --system --add safe.directory '*'

CMD ["/bin/bash"]
