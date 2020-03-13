#!/usr/bin/env bash
set -e

# We want to build and consume binary packages if available
cp /etc/portage/make.binpkg /etc/portage/make.conf/02-hacking-binpkg

# Install git so we can install our overlay
update_use 'dev-vcs/git' '-perl' '-python' '-webdav'
emerge dev-vcs/git

# Add the hacking-gentoo overlay
mkdir -p /etc/portage/repos.conf
add_overlay hacking-gentoo https://github.com/hacking-gentoo/overlay.git

# Rename the hacking-gentoo overlay so that we can still auto deploy to it without name clashes
mv /etc/portage/repos.conf/hacking-gentoo.conf /etc/portage/repos.conf/hacking-gentoo-testrunner.conf
mv /var/db/repos/hacking-gentoo /var/db/repos/hacking-gentoo-testrunner
sed-or-die "hacking-gentoo" "hacking-gentoo-testrunner" /var/db/repos/hacking-gentoo-testrunner/profiles/repo_name
sed-or-die "hacking-gentoo" "hacking-gentoo-testrunner" /etc/portage/repos.conf/hacking-gentoo-testrunner.conf
sed-or-die "sync-type.*" "" /etc/portage/repos.conf/hacking-gentoo-testrunner.conf
sed-or-die "sync-uri.*" "" /etc/portage/repos.conf/hacking-gentoo-testrunner.conf

# Unmask test tools
update_keywords 'app-portage/gentoolbox'
update_keywords 'dev-libs/github-action-lib'
update_keywords 'dev-util/codecov-bash'
update_keywords 'dev-util/kcov'

# Array of packages to install
test_tools=(
	acct-group/docker
	app-misc/jq
	app-portage/gentoolbox
	app-portage/repoman
	dev-perl/File-MimeInfo
	dev-libs/github-action-lib
	dev-util/codecov-bash
	dev-util/kcov
	dev-util/shellcheck-bin
	dev-vcs/hub-bin
	net-libs/libsmi
)

# Make necessary use / mask changes.
emerge --autounmask y --autounmask-write y --autounmask-only y "${test_tools[@]}"
etc-update --automode -5

# Install test tools
emerge "${test_tools[@]}"

# Clean any unused binary packages and distfiles to stop the caches getting polluted.
eclean-pkg --deep
eclean-dist --deep

# Seed repoman layout cache and metadata.xsd
cd /var/db/repos/test-repo
repoman || true

# Don't default to building or consuming binary packages
rm /etc/portage/make.conf/02-hacking-binpkg

# Create a testrunner user
useradd -m -G users,portage,wheel,docker -s /bin/bash testrunner

# Add portage user to required groups
 usermod --append --groups docker portage

# Remove this file
rm /usr/local/sbin/install-test-tools.sh
