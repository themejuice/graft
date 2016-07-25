#
# Cookbook Name:: graft
# Recipe:: apache
#

include_recipe "apache2"
include_recipe "apache2::mod_rewrite"
include_recipe "apache2::mod_headers"
include_recipe "apache2::mod_deflate"
include_recipe "apache2::mod_ssl"

# Copy over existing sites
Dir.glob "/srv/config/apache-config/sites/*.conf" do |conf|
  file "/etc/apache2/sites-enabled/#{File.basename conf}" do
    content File.read conf
    owner "root"
    group "root"
    mode "0644"
    action :create
  end
end

# Copy over custom config file
file "/etc/apache2/conf-enabled/overrides.conf" do
  content File.read "/srv/config/apache-config/overrides.conf"
  owner "root"
  group "root"
  mode "0644"
  action :create
end

service "apache2" do
  subscribes :restart, "file[/etc/apache2/conf-enabled/overrides.conf]", :immediately
end

# Add vagrant user to group
group "www-data" do
  action :modify
  members %w[vagrant]
  append true
end
