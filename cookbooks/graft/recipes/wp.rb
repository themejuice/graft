#
# Cookbook Name:: graft
# Recipe:: wp
#

script "wp" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-SHELL
    if [ ! -x /usr/local/bin/wp ]; then
      curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
      chmod +x /tmp/wp-cli.phar
      sudo mv /tmp/wp-cli.phar /usr/local/bin/wp
    fi
  SHELL
end
