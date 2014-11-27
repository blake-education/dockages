#!/bin/bash

set -e

docker build -t dockages/ruby-build .
docker run --volumes-from dockages-builds -e DEB_SUFFIX dockages/ruby-build ruby 2.1.5
docker run --volumes-from dockages-builds -e DEB_SUFFIX dockages/ruby-build ruby 1.9.3-p547
