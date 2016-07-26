#
# Cookbook Name:: graft
# Recipe:: webgrind
#

script "webgrind" do
  interpreter "bash"
  user "vagrant"
  group "www-data"
  cwd "/tmp"
  code <<-EOH
    if [ ! -d /srv/www/default/webgrind ]; then
      composer create-project jokkedk/webgrind /srv/www/default/webgrind
    fi
  EOH
end
