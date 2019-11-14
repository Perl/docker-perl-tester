ARG BASE
FROM perl:${BASE}

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

COPY cpanfile /tmp/

RUN apt-get update && \
        apt-get dist-upgrade -y && \
        apt-get -y --no-install-recommends install aspell aspell-en

RUN curl -sL https://cpanmin.us/ | perl - App::cpanminus && \
        cpanm -nq App::cpm && \
        cpm install -g --cpanfile /tmp/cpanfile

CMD ["/bin/bash"]
