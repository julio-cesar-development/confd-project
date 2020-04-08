# CONFD Project

[![GitHub Status](https://badgen.net/github/status/julio-cesar-development/confd-project)](https://github.com/julio-cesar-development/confd-project)

> This is a project made with CONFD to generate a configuration file for some mysql client

## Instructions

### Running with Docker

> It will build and start the app with MySQL client and MySQL server

```bash
docker-compose up
```

> There are some environment variables, if defined the configuration file will be generated with them

```bash
export MYSQL_HOST='HOST'
export MYSQL_PORT='PORT'
export MYSQL_USER='USER'
export MYSQL_PASS='PASS'
export MYSQL_DATABASE='DATABASE'
```
