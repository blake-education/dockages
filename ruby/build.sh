#!/bin/bash

set -e

cd base

docker build -t dockages/ruby-base .
cd ..

mkdir -p ../repos/debs

make_ruby() {
  ruby="$1"
  cd $ruby
  docker build --rm=false -t dockages/ruby-$ruby .
  cd ..

  id=$(docker inspect -f '{{.Container}}' dockages/ruby-$ruby)
  echo $id

  file="ruby-$ruby$BUILD_SUFFIX_amd64.deb"
  file_runtime="ruby-runtime-$ruby$BUILD_SUFFIX_amd64.deb"

  docker cp $id:/$file ../repo/debs
  docker cp $id:/$file_runtime ../repo/debs
}

make_ruby 2.1.5
make_ruby 1.9.3-p547
