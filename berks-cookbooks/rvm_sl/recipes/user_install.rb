#
# Cookbook Name:: rvm_sl
# Recipe:: user_install
#
# Copyright 2015, David Saenz Tagarro
#
# All rights reserved - Do Not Redistribute
#

username = node['rvm']['user']['name']
home = node['rvm']['user']['home']
keyserver = node['rvm']['keyserver']
recv_keys = node['rvm']['recv-keys']

include_recipe 'rvm_sl::system_requirements'

group 'rvm' do
  members [username, 'root']
  append true
end

execute 'installing_public_key' do
  command "gpg --keyserver #{keyserver} --recv-keys #{recv_keys}"
  cwd home
  environment 'USER' => username, 'HOME' => home
  group 'rvm'
  user username
  not_if 'which rvm'
end

execute 'installing_rvm' do
  command '\curl -sSL https://get.rvm.io | bash -s stable'
  cwd home
  environment 'USER' => username, 'HOME' => home
  group 'rvm'
  user username
  not_if 'which rvm'
end

execute 'bootstraping_bashrc' do
  command "echo '[[ -s \"$HOME/.rvm/scripts/rvm\" ]] && " \
          "source \"$HOME/.rvm/scripts/rvm\"' >> .bashrc"
  cwd home
  environment 'USER' => username, 'HOME' => home
  user username
  group 'rvm'
  not_if 'grep -q rvm $HOME/.bashrc'
end

cookbook_file 'copying_gemrc' do
  group 'rvm'
  path File.join(home, '.gemrc')
  source 'gemrc'
  user username
end
