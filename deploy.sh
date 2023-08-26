#!/bin/bash
cd /home/yc-user/
sudo git clone -b monolith https://github.com/express42/reddit.git
cd /home/yc-user/reddit && sudo bundle install
sudo puma -d
