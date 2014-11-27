#!/bin/bash

set -e
set -x

sudo docker build -t blake/collectd .

id=$(sudo docker inspect -f '{{.container}}' blake/collectd)
sudo docker cp $id:/collectd-5.4.1-blake1_amd64.deb ../repo/debs
