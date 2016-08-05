VAGRANT_VERSION = Vagrant::VERSION.sub /^v/, ""
VAGRANT_DIR = File.expand_path File.dirname(__FILE__)

Vagrant.configure "2" do |config|
  config.vm.box = "themejuice/graft"
  config.vm.box_version = "2.0.2"

  config.vm.provider :virtualbox do |v|
    v.customize ["modifyvm", :id, "--memory", 2048]
    v.customize ["modifyvm", :id, "--cpus", 1]
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
  end

  # A private network is created by default – this is the IP address through which
  # your host machine will communicate with the guest
  config.vm.hostname = "graft.dev"
  config.vm.network :private_network, {
    ip: "192.168.13.37"
  }

  # Add forwarded port for Mailcatcher
  config.vm.network :forwarded_port, host: 1080, guest: 1080

  # Enable agent forwarding on vagrant ssh commands. This allows you to use ssh keys
  # on your host machine inside the guest. See the manual for `ssh-add`.
  config.ssh.forward_agent = true

  # Add public key to box, so that we can SSH into it without a password
  config.vm.provision :shell, name: "add-public-key" do |s|
    ssh_pub_path = File.join Dir.home, ".ssh", "id_rsa.pub"
    if File.exist? ssh_pub_path
      ssh_pub_key = IO.readlines(ssh_pub_path).first.strip

      s.privileged = false
      s.inline = <<-SHELL
        if [ -z \"\$(grep \"#{ssh_pub_key}\" ~/.ssh/authorized_keys )\" ]; then
          echo -e \"\n#{ssh_pub_key}\" >> ~/.ssh/authorized_keys
          echo "Public key added to ~/.ssh/authorized_keys"
        fi
      SHELL
    end
  end

  # Fix 'no tty' output
  config.vm.provision :shell, name: "fix-no-tty" do |s|
    s.privileged = false
    s.inline = "sudo sed -i '/tty/!s/mesg n/tty -s \\&\\& mesg n/' /root/.profile"
  end

  # Resource configuration files
  config.vm.synced_folder "config", "/srv/config"

  # Various shell scripts
  config.vm.synced_folder "scripts", "/srv/scripts"

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

  config.vm.provision :chef_solo do |chef|

    # Vendored cookbooks directory – this is so users don't need Chef or Berks
    # installed on their machine to run the provisioners
    chef.cookbooks_path = %w[berks-cookbooks]

    chef.add_recipe "resolver"
    chef.add_recipe "system"
    chef.add_recipe "locale"
    chef.add_recipe "apt"
    chef.add_recipe "git"
    chef.add_recipe "vim"

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
    chef.add_recipe "graft::phpmyadmin"
    chef.add_recipe "graft::phpmemcacheadmin"
    chef.add_recipe "graft::webgrind"

    chef.json = {
      resolver: {
        nameservers: %w[8.8.8.8 8.8.4.4]
      },
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
        enabled: false
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
        install_method: "binary",
        version: "6.3.0",
        binary: {
          checksum: "9302affb9844ec9a51e774169072bff3421c0232f746b3d504ba6c13c749ff9f"
        }
      }
    }
  end

  # Service startups (always run)
  config.vm.provision :shell, {
    path: File.join("scripts", "init-services.sh"),
    name: "services",
    run: "always"
  }

  # If the vagrant-triggers plugin is installed:
  # - Run the database init script after the VM is booted
  # - Run the database backup script before the VM is shutdown
  if Vagrant.has_plugin? "vagrant-triggers"
    config.trigger.after [:up], stdout: true do
      run "vagrant ssh -c '/srv/scripts/init-db.sh'"
    end
    config.trigger.before [:suspend, :halt], stdout: true do
      run "vagrant ssh -c '/srv/scripts/backup-db.sh'"
    end
  end
end
