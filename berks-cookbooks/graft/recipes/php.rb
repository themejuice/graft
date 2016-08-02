#
# Cookbook Name:: graft
# Recipe:: php
#

version = node["php"]["version"]

# Install php from ondrej repo
apt_repository "php" do
  uri "ppa:ondrej/php"
  distribution "trusty"
  components %w[main]
  deb_src true
end

packages = %w[
  common
  cli
  dev
  curl
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

# Install Apache module for version
package "libapache2-mod-php#{version}"

# Copy over custom config file
file "/etc/php/#{version}/apache2/conf.d/overrides.ini" do
  content File.read "/srv/config/php-config/overrides.ini"
  owner "root"
  group "root"
  mode "0644"
  action :create
end

# Restart apache and subscribe to custom config file
service "apache2" do
  subscribes :restart, "file[/etc/php/#{version}/apache2/conf.d/overrides.ini]", :immediately
  action :restart
end
