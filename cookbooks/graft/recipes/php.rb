#
# Cookbook Name:: graft
# Recipe:: php
#

version = node["php"]["version"]

# Install php from ondrej repo
apt_repository "php" do
  uri "ppa:ondrej/php"
  distribution "trusty"
end

packages = %w[
  common
  cli
  curl
  dev
  cgi
  gd
  mbstring
  mcrypt
  mysql
  opcache
  xml
  xmlrpc
  zip
]

packages.each do |pkg|
  package "php#{version}-#{pkg}"
end

# Install other packages we might find useful
package "php-memcache"
package "php-imagick"
package "php-xdebug"
