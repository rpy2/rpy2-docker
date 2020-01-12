This helps build a jupyter-based data science environment for R + Python.
This image will include more experimental and external dependency than
`rpy2/jupyter-ubuntu`.

The naming convention for the base image is the one used in the documentation for the
base rpy2 image (see its [README](../base/README.md)).

```bash
docker build -t rpy2/jupyter_ds-ubuntu:master-default .
```

As with the base image, the ubuntu release and rpy2 version can be specified at
build time (again, see the documentation for the base image).

```bash
RPY2_VERSION=3.2.4
UBUNTU_RELEASE=19.10
docker build -t rpy2/jupyter_ds-ubuntu:"${RPY2_VERSION}"-default \
  --build-arg RPY2_VERSION="${RPY2_VERSION}" \
  --build-arg UBUNTU_RELEASE="${UBUNTU_RELEASE}" .
```
