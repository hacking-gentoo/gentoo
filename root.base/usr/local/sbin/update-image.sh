#!/usr/bin/env bash
set -e

emerge -uDN world
etc-update --automode -5
emerge app-portage/eix app-portage/flaggie app-portage/gentoolkit
emerge --depclean
revdep-rebuild
#egencache --update --tolerant --repo gentoo --jobs 4
eix-update
rm /var/cache/distfiles/* -rf
rm /usr/local/sbin/update-image.sh
