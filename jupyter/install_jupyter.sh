python3 -m pip --no-cache-dir install jupyter notebook
python3 -m pip --no-cache-dir install jupyterlab
python3 -m pip --no-cache-dir install bokeh
python3 -m pip --no-cache-dir install ipywidgets
jupyter nbextension enable --py --sys-prefix widgetsnbextension
jupyter labextension install @jupyter-widgets/jupyterlab-manager
python3 -m pip --no-cache-dir install jupyterhub
