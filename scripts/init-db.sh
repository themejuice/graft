#!/bin/bash

# Create the databases (unique to system) that will be imported with
# the mysqldump files located in database/backups/
if [ -f "/srv/database/init-custom.sql" ]; then
  mysql -u root -proot < /srv/database/init-custom.sql 2> /dev/null
fi

# Setup MySQL by importing an init file that creates necessary
# users and databases that our vagrant setup relies on.
mysql -u root -proot < /srv/database/init.sql 2> /dev/null

# Process each mysqldump SQL file in database/backups to import
# an initial data set for MySQL.
/srv/scripts/import-db.sh
