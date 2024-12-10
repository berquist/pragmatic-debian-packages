FROM debian:bookworm-20241202

# hadolint ignore=DL3008
RUN --mount=target=/var/lib/apt/lists,type=cache,sharing=locked \
    --mount=target=/var/cache/apt,type=cache,sharing=locked \
    rm -f /etc/apt/apt.conf.d/docker-clean \
    && apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    debhelper \
    devscripts \
    dh-make \
    dh-python \
    dh-virtualenv \
    fakeroot \
    git \
    golang \
    leiningen \
    libevent-dev \
    lintian \
    nodejs \
    npm \
    pkg-config \
    python3-all \
    python3-setuptools \
    quilt \
    wget

# ARG USERNAME=builder
# RUN useradd --uid 1001 --user-group -s /bin/bash ${USERNAME}
# USER ${USERNAME}

# Used for running commands instead of a shell script or Makefile
ARG JUST_VERSION=1.37.0
ARG JUST_FILENAME=just-${JUST_VERSION}-x86_64-unknown-linux-musl.tar.gz
ARG JUST_LOC=/tmp/just

WORKDIR ${JUST_LOC}
RUN curl -L -O https://github.com/casey/just/releases/download/${JUST_VERSION}/${JUST_FILENAME} \
    && tar xf ${JUST_FILENAME}
ENV PATH="${JUST_LOC}:${PATH}"

WORKDIR /repo
