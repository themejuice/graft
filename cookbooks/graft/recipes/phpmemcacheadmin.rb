#
# Cookbook Name:: graft
# Recipe:: phpmemcacheadmin
#

script "phpmemcacheadmin" do
  interpreter "bash"
  user "vagrant"
  group "www-data"
  cwd "/tmp"
  code <<-EOH
    if [ ! -d /srv/www/default/phpmemcacheadmin ]; then
      composer create-project wp-cloud/phpmemcacheadmin /srv/www/default/phpmemcacheadmin
    fi
  EOH
end
