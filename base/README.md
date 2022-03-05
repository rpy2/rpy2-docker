This helps build a base rpy2 ubuntu image.


```bash
docker build -t rpy2/base-ubuntu:master-default .
```

This will try to build rpy2's master branch, but a specific
branch/tag can be specified at build time.

For example, to build an image with rpy2 release 3.4.6

```bash
RPY2_VERSION=3.2.5
docker build -t rpy2/base-ubuntu:"${RPY2_VERSION}"-default --build-arg RPY2_VERSION="${RPY2_VERSION}" .
```

The default ubuntu release is, at the time of writing, `20.04`
but a different release can be specified at build time (e.g., `20.10`).

For example:

```bash
UBUNTU_RELEASE=20.04
docker build -t rpy2/base-ubuntu:master-"${UBUNTU-RELEASE}" --build-arg UBUNTU_RELEASE=$UBUNTU_RELEASE .
```
