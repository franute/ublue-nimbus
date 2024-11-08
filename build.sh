#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

### Setup repositories ###

curl -Lo /etc/yum.repos.d/atim-starship-fedora-"${RELEASE}".repo https://copr.fedorainfracloud.org/coprs/atim/starship/repo/fedora-"${RELEASE}"/atim-starship-fedora-"${RELEASE}".repo
curl -Lo /etc/yum.repos.d/atim-ubuntu-fonts-fedora-"${RELEASE}".repo https://copr.fedorainfracloud.org/coprs/atim/ubuntu-fonts/repo/fedora-"${RELEASE}"/atim-ubuntu-fonts-fedora-"${RELEASE}".repo

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
# rpm-ostree install screen
rpm-ostree install evince simple-scan ubuntu-family-fonts \
            fira-code-fonts cascadia-code-nf-fonts \
            java-17-openjdk

rpm-ostree override remove virtualbox-guest-additions \
            gnome-shell-extension-background-logo

# this would install a package from rpmfusion
# rpm-ostree install vlc

#### Example for enabling a System Unit File

systemctl enable podman.socket
systemctl disable flatpak-add-fedora-repos
systemctl disable NetworkManager-wait-online

### Cleanup ###

# Remove unnecessary packages
rpm-ostree cleanup -m

# Remove temporary files and caches
rm -rf /var/cache/dnf /var/lib/dnf /tmp/* /var/tmp/*

# Disable newly added repositories
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/atim-starship-fedora-"${RELEASE}".repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/atim-ubuntu-fonts-fedora-"${RELEASE}".repo
