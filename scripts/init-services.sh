#!/bin/bash

# Restart all required services
sudo service apache2 restart
sudo service mysql-default restart
sudo service memcached restart
sudo service mailcatcher restart 2> /dev/null
