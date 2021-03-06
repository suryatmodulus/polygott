#!/bin/bash
set -ev
shopt -s dotglob

groupadd -g 1000 runner
useradd -m -d /home/runner -g runner -s /bin/bash runner --uid 1000 --gid 1000

DEBIAN_FRONTEND=noninteractive apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends apt-utils build-essential busybox ca-certificates chromium-chromedriver cmake curl dirmngr ffmpeg firefox-geckodriver fluxbox git gnupg gnuplot-qt golang-go gpg-agent jq libboost-all-dev libc6-dbg libopus0 libopusfile0 libsdl-dev libsdl2-dev locales man mercurial mesa-utils ninja-build redis-tools rlwrap rsync silversearcher-ag software-properties-common ssh subversion tigervnc-standalone-server unzip valgrind vim wget x11-apps

rm -rf /var/lib/apt/lists/*

locale-gen en_US.UTF-8
update-locale LANG=en_US.UTF-8
update-ca-certificates

wget -nv \
  https://launchpad.net/ubuntu/+archive/primary/+files/libtinfo6_6.1+20181013-2ubuntu2_amd64.deb \
  https://launchpad.net/ubuntu/+archive/primary/+files/libreadline8_8.0-1_amd64.deb \
  https://storage.googleapis.com/container-bins/stderred_1.0_amd64.deb
dpkg -i *.deb
rm *.deb

mkdir /config
chown runner:runner /config

rm /phase0.sh
