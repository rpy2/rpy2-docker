mkdir /home/"${NB_USER}"/work
mkdir /home/"${NB_USER}"/.jupyter
mkdir /home/"${NB_USER}"/.local
echo "cacert=/etc/ssl/certs/ca-certificates.crt" > /home/"${NB_USER}"/.curlrc
echo "c.NotebookApp.ip = '0.0.0.0'" >> /home/"${NB_USER}"/.jupyter/jupyter_notebook_config.py
python3 -m venv /home/"${NB_USER}"/py3_env
echo "source /home/${NB_USER}/py3_env/bin/activate" >> /home/"${NB_USER}"/.bashrc
echo "echo Python virtual environment activated. Write \"deactivate\" to exit it." >> /home/"${NB_USER}"/.bash
chown -R "${NB_USER}" /home/"{NB_USER}"/
