#!/usr/bin/env bash
reddit_script="reddit_svc.sh"
cd ~
echo "#!/usr/bin/env bash" > $reddit_script
apt install -y git
git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install
