#!/bin/bash

set -e

deb_basename=ruby
deb_runtime_basename=ruby-runtime
deb_output_dir=/builds/debs


ruby_engine="$1"
ruby_version="$2"
ruby_full_version="$ruby_engine-$ruby_version"

src_dir=/builds/$ruby_engine/$ruby_version

install_path="/opt/rubies/$ruby_full_version"

echo installing $ruby_full_version
ruby-install $ruby_engine $ruby_version --src-dir $src_dir --install-dir $install_path -- --enable-load-relative --disable-install-rdoc


source /usr/local/share/chruby/chruby.sh

chruby $ruby_full_version

echo installing bundler

# find out exactly where the ruby's private gems should be installed
eval $(ruby - <<EOF
begin; require 'rubygems'; rescue LoadError; end
puts "INSTALL_DIR=#{Gem.default_dir.inspect};" if defined?(Gem)
EOF
)
gem install --install-dir="$INSTALL_DIR" --no-ri --no-rdoc -E bundler

gem install fpm --no-rdoc --no-ri


mkdir -p $deb_output_dir

# full runtime version
fpm -f -s dir \
  -t deb \
  -n $deb_runtime_basename \
  -v $ruby_version$DEB_SUFFIX \
  -C $install_path \
  --prefix usr \
  -p $deb_output_dir/$deb_runtime_basename-VERSION_ARCH.deb \
  -d "build-essential (> 0)" \
  -d "libxslt1-dev (> 0)" \
  -d "libxml2-dev (> 0)" \
  -d "libmysqlclient-dev (> 0)" \
  -d "libpq-dev (> 0)" \
  -d "zlib1g-dev (> 0)" \
  -d "libyaml-dev (> 0)" \
  -d "libssl-dev (> 0)" \
  -d "libgdbm-dev (> 0)" \
  -d "libreadline-dev (> 0)" \
  -d "libncurses5-dev (> 0)" \
  -d "libffi-dev (> 0)" \
  .


# light version
fpm -f -s dir \
  -t deb \
  -n $deb_basename \
  -v $ruby_version$DEB_SUFFIX \
  -C $install_path \
  --prefix usr \
  -p $deb_output_dir/$deb_basename-VERSION_ARCH.deb \
  -d "libxslt1.1 (> 0)" \
  -d "libxml2 (> 0)" \
  -d "libmysqlclient18 (> 0)" \
  -d "libpq5 (> 0)" \
  -d "zlib1g (> 0)" \
  -d "libyaml-0-2 (> 0)" \
  -d "libssl1.0.0 (> 0)" \
  -d "libgdbm3 (> 0)" \
  -d "libreadline6 (> 0)" \
  -d "libncurses5 (> 0)" \
  -d "libffi6 (> 0)" \
  .
