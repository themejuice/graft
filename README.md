# Graft VM
![Graft VM dashboard screenshot](https://cloud.githubusercontent.com/assets/6979737/17339873/72cacf9a-58b3-11e6-9d8b-9de36283bd4a.png)

## Getting Started

### What is Graft?
Graft is the official virtual machine for [Theme Juice](https://www.themejuice.it),
a powerful way to develop WordPress sites locally on your machine. Theme Juice is
a cross-platform desktop application built on top of our open source command line
utility, [`tj`](https://github.com/themejuice/tj), that enables you to create,
manage and deploy local WordPress development projects at the click of a button.

**Graft VM is a high-quality LAMP development environment, configured specifically
for WordPress development, that comes pre-packaged and pre-provisioned, so that
you can get up and running as quickly as possible.**

### What is Vagrant?
[Vagrant](http://www.vagrantup.com) is a "tool for building and distributing development
environments". It works with [virtualization](http://en.wikipedia.org/wiki/X86_virtualization)
software such as [VirtualBox](https://www.virtualbox.org/) to provide a virtual machine
that is sandboxed away from your local environment. It can be shutdown, destroyed
and recreated at anytime, so feel free to break things!

### Dependencies
Before you run `vagrant up`, please ensure you have the following software installed:
- [Vagrant](http://www.vagrantup.com) (>= 1.8)
- [VirtualBox](https://www.virtualbox.org/) (>= 5.0)

Along with these Vagrant plugins:
- `vagrant-triggers` (>= 0.5.3)
- `landrush` (>= 0.18.0)

You can install the plugins with `vagrant plugin install <plugin>` if you do not
already have them installed. To view your currently installed plugins, run
`vagrant plugin list` from any directory.

### Installation
You can either use [`tj`](https://github.com/themejuice/tj) to set up your
development environment, or you can run the commands below from whatever directory
you want the VM to be installed into:

```bash
git clone https://github.com/themejuice/graft .
vagrant up
```

## What do you get?
- [Ubuntu 14.04 LTS (Trusty Tahr)](http://www.ubuntu.com/)
- [PHP 5.6](http://php.net/)
- [MySQL 5.6](http://www.mysql.com/)
- [Apache](http://httpd.apache.org/)
- [WP-CLI](http://wp-cli.org/)
- [Composer](https://getcomposer.org/)
- [Node 6.3](https://nodejs.org/)
- [NPM](https://www.npmjs.com/)
- [RVM](https://rvm.io/)
- [Ruby 2.3](https://www.ruby-lang.org/en/)
- [Bundler](http://bundler.io/)
- [Mailcatcher](http://mailcatcher.me/)
- [Memcached](http://memcached.org/)
- [Xdebug](http://xdebug.org/)
- [phpMyAdmin](http://www.phpmyadmin.net/) (Dashboard)
- [phpMemcachedAdmin](https://code.google.com/p/phpmemcacheadmin/) (Dashboard)
- [Webgrind](https://github.com/jokkedk/webgrind) (Dashboard)
- GD/Imagick
- SQLite
- cURL
- Git
- Vim
- Mcrypt

## Dashboard
You can view things such as a PHP `phpinfo()` dump, phpMemcachedAdmin, phpMyAdmin,
Webgrind and more through the main dashboard:

```
http://graft.dev
```

## Customization
You may customize your PHP, MySql and Apache configurations by modifying their
corresponding 'overrides' file within `config/`. The changes will be synced to
the virtual machine on the next `vagrant provision`.

You may disable Mailcatcher and/or Xdebug from within the `Vagrantfile` via the
Chef provisioning block. When changed, you will need to reprovision the VM
by running `vagrant provision`.

The Chef provisioning block looks something like this:

```ruby
config.vm.provision :chef_solo do |chef|
  # ...
  chef.json = {
    # ...
    xdebug: {
      enabled: false
    },
    # ...
    mailcatcher: {
      enabled: true
    },
    # ...
  }
end
```

**There are an array of options given within the `Vagrantfile` such as PHP, Ruby,
MySQL and Node versions, but none of these are guaranteed to work if modified
from their current state. Those options are provided as-is and are not officially
supported when changed; they are simply used for provisioning the box.**

## Credentials

### MySQL
- Hostname: `localhost`
- Username: `root`
- Password: `root`

### SSH
- Hostname: `192.168.13.37`
- Username: `vagrant`
- Password: `vagrant`

## Xdebug
Within `config/php-config/overrides.ini`, you'll see a section devoted to Xdebug.
By default, it will be commented out. If you'd like to use it, simply activate
Xdebug within your `Vagrantfile` (shown above), and uncomment the Xdebug settings
within the `overrides.ini` file.

If you're not going to use it, I'd recommend that you disable Xdebug, as well
disable the `xdebug.profiler`-related settings:

```ini
xdebug.profiler_enable = 0
```

Doing so should dramatically increase your virtual machine's performance. Be sure
to run `vagrant provision` to put any changes/modifications you make into effect.

## Mailcatcher
Ensure that Mailcatcher is enabled within your `Vagrantfile`, then visit:

```
http://graft.dev:1080
```

## Automatic database backup
**By default, if the `vagrant-triggers` plugin is installed**, a script will run
on `halt` and `suspend` that backs up each database to a `project.sql` file within
the `/database/backup/` directory. These will then be imported automatically on
each `vagrant up`, even if your VM has recently been `destroy`'d.

**This is done so that you have the freedom to run `vagrant destroy` without
losing all that precious data stored within your databases.** Just remember that
the database _is not_ backed up on `destroy`, so be sure to run `vagrant halt`
before a destroy if you want to back everything up.

## Automatically generated self-signed SSL certs
When a `.conf` file within `config/apache-config/sites/` contains a virtual host with
a `*:443` port number, a self-signed SSL certificate will automatically be generated
on the next provision. For example, a virtual host that looks like this,

```apache
<VirtualHost *:80>
  DocumentRoot /srv/www/tj-example
  ServerName example.dev
</VirtualHost>

<VirtualHost *:443>
  DocumentRoot /srv/www/tj-example
  ServerName example.dev
  SSLEngine on
  SSLCertificateFile "/etc/ssl/certs/example.dev.pem"
  SSLCertificateKeyFile "/etc/ssl/private/example.dev.key"
</VirtualHost>
```

will automatically get a generated certificate when provisioned. Once a site has a
certificate, another one will not be generated until the old one is removed.

### Accepting a self-signed SSL cert

#### OS X Instructions
Since it's a little unintuitive, I'll link you off [to this great tutorial on
accepting a self-signed cert](http://www.accuweaver.com/2014/09/19/make-chrome-accept-a-self-signed-certificate-on-osx/).

You may need to restart your browser to see this change take effect.

#### Windows Instructions
Know how? Create a pull request!

#### Linux Instructions
Know how? Create a pull request!

## Need Help?
* Let us know! Don't hesitate to open a new issue on GitHub if you run into
  trouble or have any tips that you think we should know.

## Contributing/Development
If you decide to take part in Graft's development, change the Vagrant box to `ubuntu/trusty64`,

```ruby
Vagrant.configure "2" do |config|
  # config.vm.box = "themejuice/graft"
  # config.vm.box_version = "2.0.2"
  config.vm.box = "ubuntu/trusty64"

  # ...
end
```

that way we can be sure that we run the provisioners on a fresh box before
building a new Atlas release. After provisioning the new release, SSH into the
virtual machine and run the following commands to clean up:

```bash
# Clean up apt's cache
sudo apt-get clean

# Zero out the drive
sudo dd if=/dev/zero of=/EMPTY bs=1M
sudo rm -f /EMPTY

# Remove everything from /tmp
sudo rm -rf /tmp/*

# Remove any of your public keys
sudo vi ~/.ssh/authorized_keys

# Stop services and remove their PIDs
sudo service apache2 stop
sudo service mysql-default stop
sudo service memcached stop
sudo service mailcatcher stop
sudo rm /run/mailcatcher.pid

# Clear bash history and exit
cat /dev/null > ~/.bash_history && history -c && exit
```

#### Notes
We're using [Berkshelf](http://berkshelf.com/) to vendor our cookbooks. You can
see our configuration within the `Berksfile`. Before shipping a new build for
the Vagrant box and uploading to Atlas, be sure to run `berks vendor`, so that
the end-user can does not need to have Berkshelf or the ChefDK installed on
their machine. Vagrant will use the cookbooks inside of the `berks-cookbooks`
directory automatically when provisioning with Chef Solo.
