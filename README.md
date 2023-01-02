# rpy2-docker

This repository is a collection of definitions (`Dockerfile` + helper
files) to build Docker images for rpy2.

![](https://github.com/rpy2/rpy2-docker/workflows/Docker%20Image%20CI/badge.svg)

There are 2 types of Docker images defined:
1. An image to build binary wheels
2. Images to run rpy2

## Image to build binary wheels

[cibuildwheel](cibuildhweel/README.md): An image to build binary wheels with
`cibuildwheel`.

## Images to run rpy2

Documentation for each image is in its corresponding directory:
- [base](base/README.md) : the base image for rpy2
- [jupyter](jupyter/README.md) : jupyter added to the base image
- [jupyter_ds](jupyter_ds/README.md) : a jupyter with added extension for data science use

Image builds are pushed to dockerhub:
- https://hub.docker.com/repository/docker/rpy2/base-ubuntu
- https://hub.docker.com/repository/docker/rpy2/jupyter-ubuntu
- https://hub.docker.com/repository/docker/rpy2/jupyter_ds-ubuntu

The `jupyter(*)-ubuntu` images are intended to work my [mybinder](https://mybinder.org).
This is demoed in [rpy2-mybinder](https://github.com/rpy2/rpy2-mybinder).
