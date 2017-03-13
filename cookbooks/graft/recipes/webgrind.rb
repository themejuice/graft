#
# Cookbook Name:: graft
# Recipe:: webgrind
#

script "webgrind" do
  interpreter "bash"
  user "vagrant"
  group "www-data"
  cwd "/tmp"
  code <<-SHELL
    if [ ! -d /srv/www/default/webgrind ]; then
      composer create-project jokkedk/webgrind /srv/www/default/webgrind --stability dev --repository '{"url":"https://github.com/jokkedk/webgrind","type":"vcs"}'
    fi
  SHELL
end
