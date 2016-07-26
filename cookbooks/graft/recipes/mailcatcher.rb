#
# Cookbook Name:: graft
# Recipe:: mailcatcher
#

if node["mailcatcher"]["enabled"]
  package "libsqlite3-dev"

  script "mailcatcher" do
    interpreter "bash"
    user "vagrant"
    cwd "/tmp"
    code <<-EOH
      mailcatcher --ip=0.0.0.0
    EOH
  end
end
