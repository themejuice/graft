#
# Cookbook Name:: rvm_sl
# Recipe:: rubies_test
#
# Copyright 2015, David Saenz Tagarro
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'rvm_sl::user_install'

rvm_rubies 'ruby-2.0.0' do
  default true
end

rvm_gem 'bundler' do
  ruby_version 'ruby-2.0.0'
end
