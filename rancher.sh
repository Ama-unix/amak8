#!/bin/bash
sudo apt install nano
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
sudo apt update && sudp apt upgrade
sudo curl https://releases.rancher.com/install-docker/20.10.sh | sh
sudo apt-get install -qq docker-ce=5:20.10.24~3-0~ubuntu-focal docker-ce-cli=5:20.10.24~3-0~ubuntu-focal containerd.io docker-compose-plugin docker-ce-rootless-extras=5:20.10.24~3-0~ubuntu-focal --allow-downgrades
sudo usermod -aG docker $USER
sudo docker run --privileged -d --restart=unless-stopped -p 80:80 -p 443:443 rancher/rancher
sudo usermod -aG sudo $USER
