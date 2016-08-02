#!/bin/bash

# Restart all required services
sudo service apache2 restart
sudo service mysql-default restart
sudo service memcached restart
sudo service mailcatcher stop 2> /dev/null
sudo service mailcatcher start 2> /dev/null
