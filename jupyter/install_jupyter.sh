python3 -m pip --no-cache-dir install jupyter notebook
python3 -m pip --no-cache-dir install jupyterlab
python3 -m pip --no-cache-dir install ipywidgets
python3 -m pip --no-cache-dir install bokeh
jupyter notebook --generate-config
npm cache clean --force
jupyter lab clean
jupyter nbextension enable --py --sys-prefix widgetsnbextension
jupyter labextension install @jupyter-widgets/jupyterlab-manager
python3 -m pip --no-cache-dir install jupyterhub
