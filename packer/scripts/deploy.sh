#!/usr/bin/env bash
cd ~
apt install -y git
git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install
sleep 60
chmod +x ~/puma_start.sh
cat ~/puma_svc | sudo tee /etc/systemd/system/puma.service
systemctl daemon-reload
systemctl enable puma.service
