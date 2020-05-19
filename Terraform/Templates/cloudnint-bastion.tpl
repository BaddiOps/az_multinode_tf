#!/usr/bin/env bash
set -x

export DEBIAN_FRONTEND="noninteractive"

sudo cp /etc/ssh/sshd_config /etc/ssh//sshd_config.orig
# sudo sed -i "/#PubkeyAuthentication/c\PubkeyAuthentication yes" /etc/ssh//sshd_config



wget -q -O - https://pkg.web.io/debian/web-ci.org.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.web.io/debian-stable binary/ > /etc/apt/sources.list.d/web.list' 
sudo apt-get update -y
sudo apt-get install web -y