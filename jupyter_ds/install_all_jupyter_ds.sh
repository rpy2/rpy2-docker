
BUILDDEPS="libssl-dev"

UBUNTU_RELEASE=$(lsb_release --release --short)

# We rely on the apt packages from the Arrow project
# but they are a little behind ubuntu releases.
[ ! "${UBUNTU_RELEASE}" \> "19.04" ]
ARROW_AVAILABLE=$?

apt-get update -qq

if (( ARROW_AVAILABLE == 0 )); then

  echo "Dependencies for Apache arrow should be available. Adding them."
  
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

  wget -O /usr/share/keyrings/apache-arrow-keyring.gpg https://dl.bintray.com/apache/arrow/$(lsb_release --id --short | tr 'A-Z' 'a-z')/apache-arrow-keyring.gpg
  tee /etc/apt/sources.list.d/apache-arrow.list <<APT_LINE
deb [arch=amd64 signed-by=/usr/share/keyrings/apache-arrow-keyring.gpg] https://dl.bintray.com/apache/arrow/$(lsb_release --id --short | tr 'A-Z' 'a-z')/ $(lsb_release --codename --short) main
deb-src [signed-by=/usr/share/keyrings/apache-arrow-keyring.gpg] https://dl.bintray.com/apache/arrow/$(lsb_release --id --short | tr 'A-Z' 'a-z')/ $(lsb_release --codename --short) main
APT_LINE
  apt-get update -qq

fi

apt-get install -y ${BUILDDEPS}

python3 -m pip install --pre jupyter-lsp

jupyter labextension install @krassowski/jupyterlab-lsp

python3 -m pip install \
         bash-language-server \
	 python-language-server[all]

R -e 'install.packages("languageserver")'

if (( ARROW_AVAILABLE == 0 )); then
    python3 -m pip install 'pyarrow==0.15.*'
    R -e 'install.packages("arrow")'
fi

rm -rf /tmp/* 
apt-get remove --purge -y ${BUILDDEPS}
apt-get autoremove -y 
apt-get autoclean -y
rm -rf /var/lib/apt/lists/*
