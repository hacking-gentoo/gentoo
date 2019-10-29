#!/usr/bin/env bash
set -e

update_use 'dev-vcs/git' '-perl' '-python' '-webdav'

emerge dev-vcs/git

mkdir -p /etc/portage/repos.conf

add_overlay hacking-gentoo https://github.com/hacking-gentoo/overlay.git

update_keywords 'dev-util/codecov-bash' '+~amd64'
update_keywords 'dev-util/kcov' '+~amd64'

emerge app-portage/repoman \
       dev-util/codecov-bash \
       dev-util/kcov \
       dev-util/shellcheck-bin

rm /var/cache/distfiles/* -rf
rm /usr/local/sbin/install-test-tools.sh
