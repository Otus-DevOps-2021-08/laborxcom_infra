#!/usr/bin/env bash
cd ~
apt install -y git
git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install
cat ../files/install_svc.sh | tee /home/ubuntu/install_svc.sh
cat ../files/puma_svc | sudo tee /etc/systemd/system/puma.service
