ARG UBUNTU_RELEASE=22.04
ARG RPY2_VERSION=master
FROM rpy2/jupyter-ubuntu:$RPY2_VERSION-$UBUNTU_RELEASE

MAINTAINER Laurent Gautier <lgautier@gmail.com>

ARG DEBIAN_FRONTEND=noninteractive

USER root
WORKDIR /root

COPY install_all_jupyter_ds.sh /opt/

RUN \
  bash /opt/install_all_jupyter_ds.sh

WORKDIR /home/"${NB_USER}"

USER $NB_USER