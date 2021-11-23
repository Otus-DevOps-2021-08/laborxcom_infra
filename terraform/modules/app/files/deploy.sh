#!/bin/bash
set -e
APP_DIR=${1:-$HOME}
mkdir $APP_DIR/reddit
# A error can appear:
# ...yandex_compute_instance.app (remote-exec): E: Unable to acquire the dpkg frontend lock (/var/lib/dpkg/lock-frontend), is another process using it?
# $sudo lsof /var/lib/dpkg/lock-frontend
# If there are some "unattende" in output then wait that process to complete.
sleep 20
sudo apt-get install -y git
git clone -b monolith https://github.com/express42/reddit.git $APP_DIR/reddit
cd $APP_DIR/reddit
bundle install
sudo mv /tmp/puma.service /etc/systemd/system/puma.service
sudo systemctl start puma
sudo systemctl enable puma
