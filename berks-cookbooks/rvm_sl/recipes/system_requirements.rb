#
# Cookbook Name:: rvm_sl
# Recipe:: system_requirements
#
# Copyright 2015, David Saenz Tagarro
#
# All rights reserved - Do Not Redistribute
#

package 'installing_rvm_installer_dependencies' do
  package_name %w(gnupg curl)
end

package 'installing_ruby_dependencies' do
  package_name %w(autoconf
                  automake
                  bison
                  g++
                  gawk
                  gcc
                  libffi-dev
                  libgdbm-dev
                  libncurses5-dev
                  libsqlite3-dev
                  libtool
                  libyaml-dev
                  patch
                  pkg-config
                  sqlite3)
end

package 'installing_ruby230_dependencies' do
  package_name %w(make
                  libreadline6-dev
                  zlib1g-dev
                  libssl-dev)
end

package 'installing_json_gem_dependencies' do
  package_name 'libgmp3-dev'
end
