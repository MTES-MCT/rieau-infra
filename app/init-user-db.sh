#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
	CREATE USER rieau WITH PASSWORD $USER_PASS;
	CREATE DATABASE rieau;
	GRANT ALL PRIVILEGES ON DATABASE rieau TO rieau;
EOSQL