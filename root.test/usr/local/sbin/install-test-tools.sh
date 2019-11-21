#!/usr/bin/env bash
set -e

# We want to build and consume binary packages if available
cp /etc/portage/make.binpkg /etc/portage/make.conf/02-hacking-binpkg

# Install git so we can install our overlay
update_use 'dev-vcs/git' '-perl' '-python' '-webdav'
emerge dev-vcs/git

# Add our overlay
mkdir -p /etc/portage/repos.conf
add_overlay hacking-gentoo https://github.com/hacking-gentoo/overlay.git

# Install test tools
update_keywords 'dev-util/codecov-bash'
update_keywords 'dev-util/kcov'

emerge app-misc/jq \
       app-portage/repoman \
       dev-perl/File-MimeInfo \
       dev-util/codecov-bash \
       dev-util/kcov \
       dev-util/shellcheck-bin \
       net-libs/libsmi

# Clean any unused binary packages and distfiles to stop the caches getting polluted.
eclean-pkg --deep
eclean-dist --deep

# Don't default to building or consuming binary packages
rm /etc/portage/make.conf/02-hacking-binpkg

# Create a testrunner user
useradd -m -G users,portage,wheel -s /bin/bash testrunner

# Remove this file
rm /usr/local/sbin/install-test-tools.sh
