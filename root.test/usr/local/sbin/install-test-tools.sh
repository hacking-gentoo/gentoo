#!/usr/bin/env bash
set -e

update_use 'dev-vcs/git' '-perl' '-python' '-webdav'

emerge dev-vcs/git

mkdir -p /etc/portage/repos.conf

add_overlay hacking-gentoo https://github.com/MADhacking/hacking-gentoo.git

update_keywords 'dev-util/kcov' '+~amd64'

emerge dev-util/kcov \
       dev-util/shellcheck-bin

rm /var/cache/distfiles/* -rf
rm /usr/local/sbin/install-test-tools.sh
