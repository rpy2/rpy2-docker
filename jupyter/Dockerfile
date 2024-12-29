ARG UBUNTU_RELEASE=24.04
ARG RPY2_VERSION=master
FROM rpy2/base-ubuntu:$RPY2_VERSION-$UBUNTU_RELEASE
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

MAINTAINER Laurent Gautier <lgautier@gmail.com>

ARG DEBIAN_FRONTEND=noninteractive
ENV JUPYTER_ENABLE_LAB=1
ARG NB_USER="jupyteruser"
ARG NB_UID="1000"
ARG NB_GID="100"

USER root

COPY install_jupyter.sh /opt/install_jupyter.sh
COPY setup_jupyter.sh /opt/setup_jupyter.sh

RUN \
  apt-get update -qq \
  && apt-get install --yes --no-install-recommends curl \
  # Install NodeJS.
  && apt-get remove -y --purge nodejs npm \
  && curl -sL https://deb.nodesource.com/setup_17.x | sudo -E bash - \
  && apt-get install -y nodejs \
  # Install Yarn.
  && wget -O - https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && apt-get update -qq \
  && apt-get install -y yarn \
  && npm install -g configurable-http-proxy \
  && rm -rf /var/lib/apt/lists/* \
  # Add notebook user to the system.
  && useradd -m -s /bin/bash -N -u "${NB_UID}" "${NB_USER}" \
  && source /opt/python3_env/bin/activate \
  && sh /opt/install_jupyter.sh \
  && echo "${NB_USER}" 'ALL=(ALL) NOPASSWD: /usr/bin/apt-get' >> /etc/sudoers \
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

# Based on Jupyter's base notebook:
# https://github.com/jupyter/docker-stacks/blob/master/base-notebook/Dockerfile
# HEALTHCHECK documentation: https://docs.docker.com/engine/reference/builder/#healthcheck
# This healtcheck works well for `lab`, `notebook`, `nbclassic`, `server` and `retro` jupyter commands
# https://github.com/jupyter/docker-stacks/issues/915#issuecomment-1068528799
HEALTHCHECK  --interval=15s --timeout=3s --start-period=5s --retries=3 \
    CMD wget -O- --no-verbose --tries=1 --no-check-certificate \
    http${GEN_CERT:+s}://localhost:8888${JUPYTERHUB_SERVICE_PREFIX:-/}api || exit 1

USER $NB_USER

ENV HOME /home/${NB_USER}
WORKDIR ${HOME}

EXPOSE 8888

CMD ["start-notebook.sh"]
