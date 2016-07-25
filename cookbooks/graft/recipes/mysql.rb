#
# Cookbook Name:: graft
# Recipe:: mysql
#

mysql_service "default" do
  version node["mysql"]["version"]
  bind_address "0.0.0.0"
  port "3306"
  data_dir "/data"
  socket "/var/run/mysqld/mysqld.sock"
  initial_root_password "root"
  action [:create, :start]
end

# Copy over custom config file
file "/etc/mysql-default/conf.d/overrides.cnf" do
  content File.read "/srv/config/mysql-config/overrides.cnf"
  owner "root"
  group "root"
  mode "0644"
  action :create
end

service "mysql-default" do
  subscribes :restart, "file[/etc/mysql-default/conf.d/overrides.cnf]", :immediately
end

include_recipe "graft::databases"
