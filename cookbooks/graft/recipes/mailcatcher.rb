#
# Cookbook Name:: graft
# Recipe:: mailcatcher
#

if node["mailcatcher"]["enabled"]
  script "mailcatcher" do
    interpreter "bash"
    user "root"
    cwd "/tmp"
    code <<-EOH
      if type mailcatcher &> /dev/null; then
        rvm wrapper default@mailcatcher --no-prefix mailcatcher catchmail
      else
        rvm default@mailcatcher --create do gem install mailcatcher --no-rdoc --no-ri
        rvm wrapper default@mailcatcher --no-prefix mailcatcher catchmail
      fi
    EOH
  end
end
