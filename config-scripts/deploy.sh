#!/bin/bash
cd /home/yc-user/
git clone -b monolith https://github.com/express42/reddit.git
cd /home/yc-user/reddit && bundle install
puma -d
