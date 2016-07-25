#
# Cookbook Name:: graft
# Recipe:: composer
#

script "composer" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
    if [ ! -x /usr/local/bin/composer ]; then
      curl -s https://getcomposer.org/installer | php
      chmod +x /tmp/composer.phar
      sudo mv /tmp/composer.phar /usr/local/bin/composer
    fi
  EOH
end
