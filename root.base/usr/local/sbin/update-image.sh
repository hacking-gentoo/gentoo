#!/usr/bin/env bash
set -e

# Convert make.conf to a directory
mv /etc/portage/make.conf ~/
mkdir /etc/portage/make.conf
mv ~/make.conf /etc/portage/make.conf/00-gentoo-defaults

# Ensure package.use is a directory
[[ -f /etc/portage/package.use ]] && rm -rf /etc/portage/package.use
[[ -d /etc/portage/package.use ]] || mkdir -p /etc/portage/package.use

# Ensure package.accept_keywords is a directory
[[ -f /etc/portage/package.accept_keywords ]] && rm -rf /etc/portage/package.accept_keywords
[[ -d /etc/portage/package.accept_keywords ]] || mkdir -p /etc/portage/package.accept_keywords

# Add our default settings
mv /etc/portage/make.extra /etc/portage/make.conf/01-hacking-defaults

# We want to build and consume binary packages if available
cp /etc/portage/make.binpkg /etc/portage/make.conf/02-hacking-binpkg

# >=app-portage/portage-utils-0.80 is bugged
update_masks '>=app-portage/portage-utils-0.80'

# Perform the update
emerge -uDN world
etc-update --automode -5
emerge app-portage/eix app-portage/flaggie app-portage/gentoolkit
emerge --depclean
revdep-rebuild
#egencache --update --tolerant --repo gentoo --jobs 4
eix-update

# Don't default to building or consuming binary packages
rm /etc/portage/make.conf/02-hacking-binpkg

# Remove this file
rm /usr/local/sbin/update-image.sh
