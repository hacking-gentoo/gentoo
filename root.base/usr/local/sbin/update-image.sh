#!/usr/bin/env bash
set -e

mv /etc/portage/make.conf ~/
mkdir /etc/portage/make.conf
mv ~/make.conf /etc/portage/make.conf/00-gentoo-defaults
mv /etc/portage/make.extra /etc/portage/make.conf/01-hacking-defaults
mv /etc/portage/make.binpkg /etc/portage/make.conf/02-hacking-binpkg

emerge -uDN world
etc-update --automode -5
emerge app-portage/eix app-portage/flaggie app-portage/gentoolkit
emerge --depclean
revdep-rebuild
#egencache --update --tolerant --repo gentoo --jobs 4
eix-update
rm /var/cache/distfiles/* -rf
rm /usr/local/sbin/update-image.sh
