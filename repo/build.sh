#!/bin/bash

set -e

repo=/repo
dst=$repo/dists/production/main/binary-amd64/

rm -rf $repo
mkdir -p $dst

cp /debs/*.deb $dst

prm -t deb -p repo -r production -a amd64 -c main --nocache

aws s3 sync --acl public-read --delete --region us-west-2 $repo/ $APT_BUCKET
