#!/bin/bash

set -e

repo=/builds/repo
dst=$repo/dists/production/main/binary-amd64/

rm -rf $repo
mkdir -p $dst

cp /builds/debs/*.deb $dst

prm -t deb -p $repo -r production -a amd64 -c main --nocache

aws s3 sync --acl public-read --delete --region $APT_REGION $repo/ $APT_BUCKET
