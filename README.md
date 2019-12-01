# Gentoo Linux docker images

[Gentoo Linux](https://www.gentoo.org/) docker images automatically built from the latest stage3
release and portage tree.

## gentoo ![Docker Pulls](https://img.shields.io/docker/pulls/madhacking/gentoo)

A Gentoo Linux docker image with minimal reconfiguration from the standard distribution.

Modified settings:
 
```
FEATURES="-ipc-sandbox -network-sandbox -pid-sandbox"
MAKEOPTS="-j3"
USE="bindist caps"
EMERGE_DEFAULT_OPTS="--quiet-build y"
```

More information can be found in the [package registry](https://github.com/hacking-gentoo/gentoo/packages).

Alternatively the docker image may be pulled from our [Docker Hub repository](https://hub.docker.com/r/madhacking/gentoo) in the usual way.

```
# docker pull madhacking/gentoo
```

## gentoo-testrunner ![Docker Pulls](https://img.shields.io/docker/pulls/madhacking/gentoo-testrunner)

A Gentoo Linux docker image with some additional utilities used by the [hacking-gentoo](https://github.com/hacking-gentoo) test / check / release actions.

Installed packages:

```
app-misc/jq
app-portage/gentoolbox
app-portage/gentoolkit
app-portage/repoman
dev-perl/File-MimeInfo
dev-util/codecov-bash
dev-util/kcov
dev-util/shellcheck-bin
net-libs/libsmi
```

More information can be found in the [package registry](https://github.com/hacking-gentoo/gentoo/packages).

Alternatively the docker image may be pulled from our [Docker Hub repository](https://hub.docker.com/r/madhacking/gentoo) in the usual way.

```
# docker pull madhacking/gentoo-testrunner
```

