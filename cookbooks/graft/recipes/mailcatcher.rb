#
# Cookbook Name:: graft
# Recipe:: mailcatcher
#

user_home = node["rvm"]["user"]["home"]

# Dependency for mailcatcher
package "libsqlite3-dev"

# Install init.d script for managing the mailcatcher service
file "/etc/init.d/mailcatcher" do
  owner "root"
  group "root"
  mode "0755"
  content <<-EOH
    #!/bin/bash

    PID_FILE=/var/run/mailcatcher.pid
    NAME=mailcatcher
    PROG="#{user_home}/.rvm/wrappers/default/mailcatcher"
    USER=root
    GROUP=root

    start() {
      echo -n "Starting MailCatcher"
      if start-stop-daemon --stop --quiet --pidfile $PID_FILE --signal 0
      then
        echo " already running."
        exit
      fi
      start-stop-daemon \\
        --start \\
        --pidfile $PID_FILE \\
        --make-pidfile \\
        --background \\
        --exec $PROG \\
        --user $USER \\
        --group $GROUP \\
        --chuid $USER \\
        -- \\
        --foreground \\
        --ip=0.0.0.0
      echo "."
      return $?
    }

    stop() {
      echo -n "Stopping MailCatcher"
      start-stop-daemon \\
        --stop \\
        --oknodo \\
        --pidfile $PID_FILE
      echo "."
      return $?
    }

    restart() {
      stop
      start
    }

    case "$1" in
      start)
        start
        ;;
      stop)
        stop
        ;;
      restart)
        restart
        ;;
      *)
        echo "Usage: $0 {start|stop|restart}"
        exit 1
        ;;
    esac
  EOH
  action :create
end

# Install mailcatcher
script "mailcatcher" do
  interpreter "bash"
  user "vagrant"
  cwd "/tmp"
  code <<-EOH
    if ! type mailcatcher &> /dev/null; then
      source "#{user_home}/.rvm/scripts/rvm"
      rvm default@mailcatcher --create do gem install mailcatcher --no-rdoc --no-ri
      rvm wrapper default@mailcatcher --no-prefix mailcatcher catchmail
    fi
  EOH
end

# Toggle the mailcatcher service
service "mailcatcher" do
  if node["mailcatcher"]["enabled"]
    action :start
  else
    action :stop
  end
end
