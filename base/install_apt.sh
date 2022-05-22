apt-get update -qq
apt install -y --no-install-recommends \
    software-properties-common \
    dirmngr \
    lsb-release
    wget
wget -qO- "${CRAN_MIRROR}"/bin/linux/ubuntu/marutter_pubkey.asc \
    | tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
add-apt-repository \
        --yes \
        "deb ${CRAN_MIRROR}/bin/linux/ubuntu/ $(lsb_release -c -s)${CRAN_MIRROR_TAG}/"
apt-get update -qq
apt-get install -y \
        aptdaemon \
        ed \
        git \
	mercurial \
	libcairo-dev \
	libedit-dev \
	libxml2-dev \
	python3 \
	python3-pip \
	python3-venv \
	r-base \
	r-base-dev \
	sudo
rm -rf /var/lib/apt/lists/*
