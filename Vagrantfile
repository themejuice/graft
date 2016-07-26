VAGRANT_VERSION = Vagrant::VERSION.sub /^v/, ""
VAGRANT_DIR = File.expand_path File.dirname(__FILE__)

Vagrant.configure "2" do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.provider :virtualbox do |v|
    v.customize ["modifyvm", :id, "--memory", 1024 * 2]
    v.customize ["modifyvm", :id, "--cpus", 1]
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
  end

  # Enable agent forwarding on vagrant ssh commands. This allows you to use ssh keys
  # on your host machine inside the guest. See the manual for `ssh-add`.
  config.ssh.forward_agent = true

  # A private network is created by default – this is the IP address through which
  # your host machine will communicate with the guest
  config.vm.hostname = "graft.dev"
  config.vm.network :private_network, {
    ip: "192.168.13.37"
  }

  # Add forwarded port for Mailcatcher
  config.vm.network :forwarded_port, host: 1080, guest: 1080

  # Fix 'no tty' output
  config.vm.provision "fix-no-tty", type: "shell" do |s|
    s.privileged = false
    s.inline = "sudo sed -i '/tty/!s/mesg n/tty -s \\&\\& mesg n/' /root/.profile"
  end

  # Resource configuration files
  config.vm.synced_folder "config", "/srv/config"

  # Database resources and backups
  config.vm.synced_folder "database", "/srv/database"

  # Log files
  config.vm.synced_folder "log", "/srv/log", {
    owner: "vagrant",
    group: "www-data"
  }

  # Web root
  config.vm.synced_folder "www", "/srv/www", {
    owner: "vagrant",
    group: "www-data",
    mount_options: ["dmode=775", "fmode=774"]
  }

  # Load in Customfile containing local projects and configuration
  customfile = File.join VAGRANT_DIR, "Customfile"
  eval IO.read(customfile), binding if File.exist? customfile

  # Chef provisioning
  config.berkshelf.enabled = true
  config.berkshelf.berksfile_path = "cookbooks/Berksfile"

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = %w[cookbooks]

    chef.add_recipe "system"
    chef.add_recipe "locale"
    chef.add_recipe "apt"

    chef.add_recipe "graft::certs"
    chef.add_recipe "graft::apache"
    chef.add_recipe "graft::mysql"
    chef.add_recipe "graft::php"
    chef.add_recipe "graft::xdebug"
    chef.add_recipe "graft::composer"
    chef.add_recipe "graft::wp"
    chef.add_recipe "graft::memcached"
    chef.add_recipe "graft::ruby"
    chef.add_recipe "graft::mailcatcher"
    chef.add_recipe "graft::node"

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
      xdebug: {
        enabled: true
      },
      mysql: {
        version: "5.6"
      },
      apache: {
        listen: %w[*:80 *:443],
        group: "www-data",
        user: "vagrant",
        mpm: "prefork"
      },
      memcached: {
        listen: "0.0.0.0",
        logfilepath: "/srv/log/memcache",
        logfilename: "memcache.log"
      },
      rvm: {
        user: {
          name: "vagrant",
          home: "/home/vagrant"
        }
      },
      ruby: {
        version: "2.3.0",
        gems: %w[]
      },
      mailcatcher: {
        enabled: true
      },
      nodejs: {
        version: "6.3.0"
      }
    }
  end
end
