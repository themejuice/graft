#!/bin/bash
#
# Create individual SQL files for each database. These files
# are imported automatically during an initial provision if
# the databases exist per the import-sql.sh process.
mysql -u root -proot -e "show databases" 2> /dev/null | \
  grep -v -F "information_schema" | \
  grep -v -F "performance_schema" | \
  grep -v -F "mysql" | \
  grep -v -F "test" | \
  grep -v -F "Database" | \
  while read db_name; do
    mysqldump -uroot "$db_name" > "/srv/database/backup/$db_name.sql" 2> /dev/null
    echo "Backed up database '$db_name'"
  done
