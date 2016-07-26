# Graft VM
![Graft VM dashboard screenshot]()

## Getting Started

### What is Graft?
Graft is the official virtual machine for [Theme Juice](https://www.themejuice.it),
a powerful way to develop WordPress sites locally on your machine. Theme Juice is
a cross-platform desktop application built on top of our open source command line
utility, [`tj`](https://github.com/themejuice/cli), that enables you to create,
manage and deploy local WordPress development projects at the click of a button.

**Graft VM is a high-quality LAMP development environment, configured specifically
for WordPress development, that comes prepackaged and requires no provisioning so
that you can get up and running as quickly as possible.**

### What is Vagrant?
[Vagrant](http://www.vagrantup.com) is a "tool for building and distributing development
environments". It works with [virtualization](http://en.wikipedia.org/wiki/X86_virtualization)
software such as [VirtualBox](https://www.virtualbox.org/) to provide a virtual machine
that is sandboxed away from your local environment. It can be shutdown, destroyed
and recreated at anytime, so feel free to break things!

### Installation
You can either use [`tj`](https://github.com/themejuice/cli) to set up your
development environment, or you can run the commands below from whatever directory
you want the VM to be installed into:

```bash
git clone https://github.com/themejuice/graft
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
Webgrind, OPcache Status and more through the main dashboard:

```
http://graft.dev
```

## Customization
You may customize your PHP, MySql and Apache configurations by modifying their
corresponding 'overrides' file within `config/`. The changes will be synced to
the virtual machine on the next `up` or `reload`.

You may disable Mailcatcher and/or Xdebug from within the `Vagrantfile` within
the Chef provisioning block. When changed, you will need to reprovision the VM
by running `vagrant provision`.

The Chef provisioning block looks something like this:

```ruby
config.vm.provision :chef_solo do |chef|
  # ...
  chef.json = {
    # ...
    xdebug: {
      enabled: true
    },
    # ...
    mailcatcher: {
      enabled: true
    },
    # ...
  }
end
```

**There is an array of options given within the `Vagrantfile` such as PHP, Ruby,
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

## Mailcatcher
Ensure that Mailcatcher is enabled within your `Vagrantfile`, then visit:

```
http://graft.dev:1080
```

## Automatic database backup
By default, **if the `vagrant-triggers` plugin is installed**, a script will run
on `halt`, `suspend`, and `destroy` that backs up each database to a `$name.sql`
file within the `/database/backup/` directory. These will then be imported
automatically on each `vagrant up`, even if your VM has recently been `destroy`'d.

**This is done so that you have the freedom to run `vagrant destroy` without
losing all that precious data within stored in your databases.**

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
accepting a self-signed cert](https://www.accuweaver.com/2014/09/19/make-chrome-accept-a-self-signed-certificate-on-osx/).

You may need to restart your browser to see this change take effect.

#### Windows Instructions
Know how? Create a pull request!

#### Linux Instructions
Know how? Create a pull request!

## Need Help?
* Let us have it! Don't hesitate to open a new issue on GitHub if you run into
  trouble or have any tips that we need to know.
