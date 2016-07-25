#
# Cookbook Name:: graft
# Recipe:: mailcatcher
#

if node["mailcatcher"]["enabled"]
  script "mailcatcher" do
    interpreter "bash"
    user "root"
    cwd "/tmp"
    code "mailcatcher"
  end
end
