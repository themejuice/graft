#
# Cookbook Name:: graft
# Recipe:: certs
#

directory "/etc/ssl" do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

directory "/etc/ssl/private" do
  owner "root"
  group "root"
  mode "0710"
  action :create
end

# Generate a self-signed SSL cert for each site
Dir.glob "/srv/config/apache-config/sites/*.conf" do |conf|
  /\*:443.*?ServerName\s+(?:www\.)?([-\.0-9a-z]+)/mi =~ File.read(conf)
  domain = "#{$1}".gsub /^www\./, ""

  script "cert-#{domain}" do
    interpreter "bash"
    user "root"
    cwd "/tmp"
    code <<-SHELL
      if [ ! -f "/etc/ssl/certs/#{domain}.pem" ]; then
        openssl genrsa -des3 -passout pass:x -out "#{domain}.pass.key" 2048 &>/dev/null
        openssl rsa -passin pass:x -in "#{domain}.pass.key" -out "#{domain}.key" &>/dev/null
        rm "#{domain}.pass.key"
        openssl req -new -key "#{domain}.key" -out "#{domain}.csr" -subj "/C=US/ST=New York/L=New York City/O=F Society/OU=Security/CN=#{domain}" &>/dev/null
        openssl x509 -req -days 365 -in "#{domain}.csr" -signkey "#{domain}.key" -out "#{domain}.pem" &>/dev/null

        chmod 640 "#{domain}.key"
        chmod 644 "#{domain}.pem"
        mv "#{domain}.key" /etc/ssl/private/
        mv "#{domain}.pem" /etc/ssl/certs/
        rm "#{domain}.csr"
      fi
    SHELL
  end
end
