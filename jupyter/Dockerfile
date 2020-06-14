ARG UBUNTU_RELEASE=20.04
ARG RPY2_VERSION=master
FROM rpy2/base-ubuntu:$RPY2_VERSION-$UBUNTU_RELEASE

MAINTAINER Laurent Gautier <lgautier@gmail.com>

ARG DEBIAN_FRONTEND=noninteractive
ENV JUPYTER_ENABLE_LAB=1
ARG TINI_VERSION=v0.19.0
ENV SHELL=/bin/bash \
    NB_USER=jupyteruser \
    NB_UID=1000

USER root

COPY install_jupyter.sh /opt/install_jupyter.sh
COPY setup_jupyter.sh /opt/setup_jupyter.sh

RUN \
  apt-get update -qq \
  && apt-get install -y curl \
  && apt-get remove -y --purge nodejs npm \
  && curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash - \
  && apt-get install -y nodejs \
  && wget -O - https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && apt-get update -qq \
  && apt-get install -y yarn \
  && npm install -g configurable-http-proxy \
  && rm -rf /var/lib/apt/lists/* \
  && useradd -m -s /bin/bash -N -u "${NB_UID}" "${NB_USER}" \
  && sh /opt/install_jupyter.sh \
  && echo "${NB_USER}" 'ALL=(ALL) NOPASSWD: /usr/bin/apt-get' >> /etc/sudoers \
  && wget --quiet https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini \
      -P /usr/local/bin/ \
  && chmod +x /usr/local/bin/tini \
  && sh /opt/setup_jupyter.sh \
  && echo "Add Jupyter scripts emerging as ad hoc interface" \
  && git clone --depth=1 https://github.com/jupyter/docker-stacks.git /tmp/docker-stacks \
  && cd /tmp/docker-stacks/base-notebook \
  && sed -e 's/jovyan/'"${NB_USER}"'/g' start.sh > /usr/local/bin/start.sh \
  && cp start-notebook.sh /usr/local/bin/ \
  && cp start-singleuser.sh /usr/local/bin/ \
  && mkdir -p /etc/jupyter/ \
  && cp jupyter_notebook_config.py /etc/jupyter/ \
  && rm -rf /tmp/docker-stacks

USER $NB_USER

ENV HOME /home/${NB_USER}
WORKDIR ${HOME}

EXPOSE 8888

ENTRYPOINT ["/usr/local/bin/tini", "--"]
CMD ["start-notebook.sh"]
