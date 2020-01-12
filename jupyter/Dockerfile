ARG UBUNTU_RELEASE=19.10
ARG RPY2_VERSION=master
FROM rpy2/base-ubuntu:$RPY2_VERSION-$UBUNTU_RELEASE

MAINTAINER Laurent Gautier <lgautier@gmail.com>

ARG DEBIAN_FRONTEND=noninteractive
ENV JUPYTER_ENABLE_LAB=1
ARG TINI_VERSION=v0.15.0
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
  && curl -sL https://deb.nodesource.com/setup_13.x | sudo -E bash - \
  && sudo apt-get install -y nodejs \
  && wget -O - https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && apt-get update -qq \
  && sudo apt-get install -y yarn \
  && npm install -g configurable-http-proxy \
  && rm -rf /var/lib/apt/lists/* \
  && useradd -m -s /bin/bash -N -u "${NB_UID}" "${NB_USER}" \
  && sh /opt/install_jupyter.sh \
  && echo "${NB_USER}" 'ALL=(ALL) NOPASSWD: /usr/bin/apt-get' >> /etc/sudoers \
  && wget --quiet https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini \
      -P /usr/local/bin/ \
  && chmod +x /usr/local/bin/tini \
  && sh /opt/setup_jupyter.sh

USER $NB_USER

WORKDIR ${HOME}

EXPOSE 8888

ENTRYPOINT ["/usr/local/bin/tini", "--"]
CMD ["start-notebook.sh"]

# Add Jupyter script(s) emerging as ad hoc interface
RUN \
  git clone --depth=1 https://github.com/jupyter/docker-stacks.git \
  && cd docker-stacks/base-notebook \
  && cp start.sh /usr/local/bin/ \
  && cp start-notebook.sh /usr/local/bin/ \
  && cp start-singleuser.sh /usr/local/bin/ \
  && mkdir -p /etc/jupyter/ \
  && cp jupyter_notebook_config.py /etc/jupyter/ \
  && chown -R "${NB_USER}":users /etc/jupyter/ \
  && cd ../../ \
  && rm -rf docker-stacks

ENV HOME /home/${NB_USER}
USER $NB_USER
