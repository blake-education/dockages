#!/bin/bash
set -e

docker run -i -t --volumes-from dockages-builds ubuntu:12.04 /bin/bash
