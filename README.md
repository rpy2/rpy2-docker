# rpy2-docker
Running rpy2 in Docker containers

![](https://github.com/rpy2/rpy2-docker/workflows/Docker%20Image%20CI/badge.svg)

Documentation for each image is in its corresponding directory:
- [base](base/README.md) : the base image for rpy2
- [jupyter](jupyter/README.md) : jupyter added to the base image
- [jupyter_ds](jupyter_ds/README.md) : a jupyter with added extension for data science use
Instruction about releases (there might be images for several ubuntu or rpy2 releases can be found there)

Image builds are pushed to dockerhub:
- https://hub.docker.com/repository/docker/rpy2/base-ubuntu
- https://hub.docker.com/repository/docker/rpy2/jupyter-ubuntu
- https://hub.docker.com/repository/docker/rpy2/jupyter_ds-ubuntu

The `jupyter(*)-ubuntu` images are intended to work my [mybinder](https://mybinder.org).
This is demoed in [rpy2-mybinder](https://github.com/rpy2/rpy2-mybinder).
