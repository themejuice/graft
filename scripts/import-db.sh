#!/bin/bash

# Import provided SQL files in to MySQL.
#
# The files in the /database/backups/ directory should be created by mysqldump
# or some other export process that generates a full set of SQL commands to
# create the necessary tables and data required by a database.
#
# For an import to work properly, the SQL file should be named `db_name.sql` in which
# `db_name` matches the name of a database already created in /database/init-custom.sql
# or /database/init.sql.
#
# If a filename does not match an existing database, it will not import correctly.
#
# If tables already exist for a database, the import will not be attempted again.
# After an initial import, the data will remain persistent and available to MySQL
# on future boots through /database/data
cd /srv/database/backup/

# Parse through each file in the directory and use the file name to
# import the SQL file into the database of the same name
sql_count=`ls -1 *.sql 2>/dev/null | wc -l`
if [ $sql_count != 0 ]; then
	for file in $( ls *.sql ); do
	db_name=${file%%.sql}
	mysql_cmd='SHOW TABLES FROM `'$db_name'`' # Required to support hypens in database names
	db_exist=`mysql -u root -proot --skip-column-names -e "$mysql_cmd" 2> /dev/null`
	if [ "$?" != "0" ]; then
		printf "  * Error - Create $db_name database via init-custom.sql before attempting import\n\n"
	else
		if [ "" == "$db_exist" ]; then
			printf "mysql -u root -proot $db_name < $db_name.sql\n"
			mysql -u root -proot $db_name < $db_name.sql 2> /dev/null
			printf "  * Import of $db_name successful\n"
		else
			printf "  * Skipped import of $db_name - tables exist\n"
		fi
	fi
	done
	printf "Databases imported\n"
else
	printf "No custom databases to import\n"
fi
