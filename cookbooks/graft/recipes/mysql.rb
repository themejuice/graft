#
# Cookbook Name:: graft
# Recipe:: mysql
#

version = node["mysql"]["version"]

# Remove existing mysql resources
execute "apt-get-autoremove" do
  command "apt-get -y autoremove"
end

apt_package "mysql*" do
  notifies :run, "execute[apt-get-autoremove]", :immediately
  action :purge
end

# Install mysql from ondrej repo
apt_repository "mysql-server" do
  uri "ppa:ondrej/mysql-#{version}"
  distribution "trusty"
end

package "mysql-server"

# Copy over config file
file "/etc/mysql/my.cnf" do
  content File.read "/srv/config/mysql-config/my.cnf"
  owner "root"
  mode "0644"
  action :create
end

# Start service
service "mysql" do
  subscribes :restart, "file[/etc/mysql/my.cnf]", :immediately
  action [:enable, :start]
end
