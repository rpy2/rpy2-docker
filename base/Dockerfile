ARG UBUNTU_RELEASE=22.04
FROM ubuntu:$UBUNTU_RELEASE

MAINTAINER Laurent Gautier <lgautier@gmail.com>

ARG DEBIAN_FRONTEND=noninteractive
ENV CRAN_MIRROR=https://cloud.r-project.org \
    CRAN_MIRROR_TAG=-cran40

ARG RPY2_VERSION=RELEASE_3_5_2
ARG RPY2_CFFI_MODE=BOTH

COPY install_apt.sh /opt/
COPY install_rpacks.sh /opt/
COPY install_pip.sh /opt/

RUN \
  sh /opt/install_apt.sh \
  && sh /opt/install_rpacks.sh \
  && sh /opt/install_pip.sh \
  && rm -rf /tmp/* \
  && apt-get remove --purge -y $BUILDDEPS \
  && apt-get autoremove -y \
  && apt-get autoclean -y \
  && rm -rf /var/lib/apt/lists/*

RUN \
  python3 -m pip --no-cache-dir install https://github.com/rpy2/rpy2/archive/refs/tags/"${RPY2_VERSION}".zip && \
  rm -rf /root/.cache
