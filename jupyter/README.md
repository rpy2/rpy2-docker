This helps build an ubuntu-based image to run jupyter with rpy2 for polyglot (python + R)
data science notebooks.

The naming convention for the base image is the one used in the documentation for the
base rpy2 image (see its [README](../base/README.md)).

```bash
docker build -t rpy2/jupyter-ubuntu:master-default .
```

As with the base image, the ubuntu release and rpy2 version can be specified at
build time (again, see the documentation for the base image).

```bash
RPY2_VERSION=3.2.4
UBUNTU_RELEASE=19.10
docker build -t rpy2/base-ubuntu:"${RPY2_VERSION}"-default \
  --build-arg RPY2_VERSION="${RPY2_VERSION}" \
  --build-arg UBUNTU_RELEASE="${UBUNTU_RELEASE}" .
```
