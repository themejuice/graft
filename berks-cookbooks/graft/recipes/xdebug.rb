#
# Cookbook Name:: graft
# Recipe:: xdebug
#

version = node["php"]["version"]
command =
  if node["xdebug"]["enabled"]
    "sudo ln -fs /etc/php/#{version}/mods-available/xdebug.ini /etc/php/#{version}/apache2/conf.d/20-xdebug.ini"
  else
    "sudo rm -f /etc/php/#{version}/apache2/conf.d/20-xdebug.ini"
  end

script "xdebug" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code command
  notifies :restart, "service[apache2]", :immediately
end
