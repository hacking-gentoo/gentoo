#!/usr/bin/env bash
set -e

emerge -uDN world
emerge app-portage/eix app-portage/flaggie app-portage/gentoolkit
emerge --depclean
revdep-rebuild
eix-update
rm /var/cache/distfiles/* -rf
