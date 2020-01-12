ARG UBUNTU_RELEASE=19.10
ARG RPY2_VERSION=master
FROM rpy2/jupyter-ubuntu:$RPY2_VERSION-$UBUNTU_RELEASE

MAINTAINER Laurent Gautier <lgautier@gmail.com>

ARG DEBIAN_FRONTEND=noninteractive

USER root

RUN python3 -m pip install --pre jupyter-lsp \
  && jupyter labextension install @krassowski/jupyterlab-lsp \
  && python3 -m pip install python-language-server[all] \
  && R -e 'install.packages("languageserver")'

USER $NB_USER