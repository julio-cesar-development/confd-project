#!/bin/bash
set -e

echo "The variables from env are :: ${!MYSQL_*}"

echo "Generating config file"
confd -onetime --log-level debug -backend env

echo "Config file generated"
cat /config.cnf

DATABASE=$(mysql --defaults-extra-file=/config.cnf -sN -e "show schemas" | grep -v "sys" | grep -v "information_schema" | grep -v "mysql" | grep -v "performance_schema")
echo "DATABASE FOUND :: ${DATABASE}"

echo "Creating a table into ${DATABASE}"
mysql --defaults-extra-file=/config.cnf -sN -e "CREATE TABLE IF NOT EXISTS ${DATABASE}.TEST_TABLE (id INT(11) AUTO_INCREMENT PRIMARY KEY, name VARCHAR(255) NOT NULL, created_at DATETIME DEFAULT NOW())"

echo "Inserting into the created table"
mysql --defaults-extra-file=/config.cnf -sN -e "INSERT INTO ${DATABASE}.TEST_TABLE (name) VALUES ('TEST_ENTRY')"

echo "Selecting from the created table"
mysql --defaults-extra-file=/config.cnf -e "SELECT * FROM ${DATABASE}.TEST_TABLE"

sleep 10

echo "executing $@"
exec "$@"
