#!/bin/bash
set -e
APP_DIR=${1:-$HOME}
mkdir $APP_DIR/reddit
#yandex_compute_instance.app (remote-exec): E: Unable to acquire the dpkg frontend lock (/var/lib/dpkg/lock-frontend), is another process using it?
sleep 20
sudo apt-get install -y git
git clone -b monolith https://github.com/express42/reddit.git $APP_DIR/reddit
cd $APP_DIR/reddit
bundle install
sudo mv /tmp/puma.service /etc/systemd/system/puma.service
sudo systemctl start puma
sudo systemctl enable puma
