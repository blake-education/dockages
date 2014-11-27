#!/bin/bash

set -e

root="$( cd "$( dirname "${BASH_SOURCE[0]}" )" > /dev/null && pwd )"

if [[ -f "$root/build.env" ]]; then
  source $root/build.env
fi


cd $root/ruby
bash build.sh

cd $root/repo
bash redo.sh
