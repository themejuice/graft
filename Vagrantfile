VAGRANT_VERSION = Vagrant::VERSION.sub /^v/, ""
VAGRANT_DIR = File.expand_path File.dirname(__FILE__)

Vagrant.configure "2" do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.hostname = "graft.dev"

  config.vm.provider :virtualbox do |v|
    v.customize ["modifyvm", :id, "--memory", 1024 * 2]
    v.customize ["modifyvm", :id, "--cpus", 1]
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
  end

  # Fix 'no tty' output
  config.vm.provision "fix-no-tty", type: "shell" do |s|
    s.privileged = false
    s.inline = "sudo sed -i '/tty/!s/mesg n/tty -s \\&\\& mesg n/' /root/.profile"
  end

  # Resource configuration files
  config.vm.synced_folder "config", "/srv/config"

  # Load in Customfile containing local projects and configuration
  customfile = File.join VAGRANT_DIR, "Customfile"
  eval IO.read(customfile), binding if File.exist? customfile

  # Chef provisioning
  config.berkshelf.enabled = true
  config.berkshelf.berksfile_path = "cookbooks/Berksfile"

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = %[cookbooks]

    chef.add_recipe "system"
    chef.add_recipe "locale"
    chef.add_recipe "apt"

    # chef.add_recipe "graft::apache2"
    chef.add_recipe "graft::mysql"
    # chef.add_recipe "graft::php"
    # chef.add_recipe "graft::composer"
    # chef.add_recipe "graft::wp"

    chef.json = {
      system: {
        timezone: "America/Chicago"
      },
      locale: {
        lang: "en_US.utf8",
        lc_all: "en_US.utf8"
      },
      php: {
        version: "5.6"
      },
      mysql: {
        version: "5.7"
      },
      apache: {
        listen: %W[80 8080]
      }
    }
  end
end
