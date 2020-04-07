#!/usr/bin/env bash
set -x

export DEBIAN_FRONTEND="noninteractive"

sudo cp /etc/ssh/sshd_config /etc/ssh//sshd_config.orig
# sudo sed -i "/#PubkeyAuthentication/c\PubkeyAuthentication yes" /etc/ssh//sshd_config