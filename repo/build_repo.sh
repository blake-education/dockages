#!/bin/bash

set -e

repo=/builds/repo
dst=$repo/dists/production/main/binary-amd64/

deb-s3 upload --arch=amd64 --codename=production --bucket=$APT_BUCKET /builds/debs/*.deb
