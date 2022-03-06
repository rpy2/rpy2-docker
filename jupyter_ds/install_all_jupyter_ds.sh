UBUNTU_RELEASE=$(lsb_release --release --short)

apt-get update -qq

BUILDDEPS="${BUILDDEPS} \
    libarrow-dev \
    libarrow-glib-dev \
    libarrow-flight-dev \
    libplasma-dev \
    libplasma-glib-dev \
    libgandiva-dev \
    libgandiva-glib-dev \
    libparquet-dev \
    libparquet-glib-dev"

APACHEARROW_URL="https://dl.bintray.com/apache/arrow/$(lsb_release --id --short \| tr 'A-Z' 'a-z')"
wget -O /usr/share/keyrings/apache-arrow-keyring.gpg \
     ${APACHEARROW_URL}/apache-arrow-keyring.gpg
tee /etc/apt/sources.list.d/apache-arrow.list <<APT_LINE
deb [arch=amd64 signed-by=/usr/share/keyrings/apache-arrow-keyring.gpg] ${APACHEARROW_URL}/ $(lsb_release --codename --short) main
deb-src [signed-by=/usr/share/keyrings/apache-arrow-keyring.gpg] ${APACHEARROW_URL}/ $(lsb_release --codename --short) main
APT_LINE
  apt-get update -qq

apt-get install -y ${BUILDDEPS}

# jupyterlab-lsp: better UI for R code cells
python3 -m pip install --pre jupyter-lsp
jupyter labextension install --no-build @krassowski/jupyterlab-lsp
jupyer lab build --dev-build=False --minimize=True
python3 -m pip install \
        bash-language-server \
	python-language-server[all]

R -e 'install.packages("languageserver")'

R -e 'install.packages(c("assertthat", "cpp11", "tidyselect", "vectrs", "R6", "purr", bit64"))'
R -e 'install.packages("arrow")'
python3 -m pip install rpy2-arrow
python3 -m pip install -e git://github.com/rpy2/rpy2-R6.git@master#egg=rpy2_R6

rm -rf /tmp/* 
apt-get remove --purge -y ${BUILDDEPS}
apt-get autoremove -y 
apt-get autoclean -y
rm -rf /var/lib/apt/lists/*
