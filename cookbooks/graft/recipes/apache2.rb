#
# Cookbook Name:: graft
# Recipe:: apache2
#

# Install apache from ondrej repo
apt_repository "apache2" do
  uri "ppa:ondrej/apache2"
  distribution "trusty"
end

# Pass configuration off to apache recipe
include_recipe "apache2"
include_recipe "apache2::mod_rewrite"
include_recipe "apache2::mod_headers"
include_recipe "apache2::mod_deflate"
