#
# Cookbook Name:: graft
# Recipe:: ruby
#

# Install RVM
include_recipe "rvm_sl::user_install"

# Install Ruby and passed gems using RVM
version = node["ruby"]["version"]

rvm_rubies "ruby-#{version}" do
  home "/home/vagrant"
  user_name "vagrant"
  default true
end

%w[bundler mailcatcher].concat(node["ruby"]["gems"]).each do |rubygem|
  rvm_gem rubygem do
    ruby_version "ruby-#{version}"
    home "/home/vagrant"
    user_name "vagrant"
  end
end
