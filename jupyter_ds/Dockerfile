ARG UBUNTU_RELEASE=19.10
ARG RPY2_VERSION=master
FROM rpy2/jupyter-ubuntu:$RPY2_VERSION-$UBUNTU_RELEASE

MAINTAINER Laurent Gautier <lgautier@gmail.com>

ARG DEBIAN_FRONTEND=noninteractive

USER root
WORKDIR /root

RUN \
  BUILDDEPS="libssl-dev" \
  && apt-get update -qq \
  && apt-get install -y ${BUILDDEPS} \
  && python3 -m pip install --pre jupyter-lsp \
  && jupyter labextension install @krassowski/jupyterlab-lsp \
  && python3 -m pip install python-language-server[all] \
  && R -e 'install.packages("languageserver")' \
  && rm -rf /tmp/* \
  && apt-get remove --purge -y ${BUILDDEPS} \
  && apt-get autoremove -y \
  && apt-get autoclean -y \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /home/"${NB_USER}"

USER $NB_USER