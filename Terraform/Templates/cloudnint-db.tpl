#!/usr/bin/env bash
set -x
source /etc/lsb-release

sudo DEBIAN_FRONTEND="noninteractive" apt-get -y dist-upgrade

sudo apt-get update -y


sudo cp /etc/ssh/sshd_config /etc/ssh//sshd_config.orig
# sudo sed -i "/#PubkeyAuthentication/c\PubkeyAuthentication yes" /etc/ssh//sshd_config

