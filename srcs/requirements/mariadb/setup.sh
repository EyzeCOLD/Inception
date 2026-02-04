#!/bin/sh
RED='\033[31m'
MAG='\033[35m'
NC='\033[0m'

set -e

ROOT_PW_FILE="/run/secrets/mariadb_root_pw"
USER_PW_FILE="/run/secrets/mariadb_user_pw"

# Only on first run
if [ ! -f "/var/lib/mysql/ibdata1" ]; then
	printf "%b\n" "${MAG}[!]${NC} First-time MariaDB setup..."

	mariadb-install-db --user=mysql --datadir=/var/lib/mysql

	mariadbd --user=mysql --datadir=/var/lib/mysql --skip-networking --console &
	pid="$!"

	# start temp server
	until mariadb-admin ping >/dev/null 2>&1; do
		sleep 1
	done

	if [ ! -f "$ROOT_PW_FILE" ]; then
		printf "%b\n" "${MAG}[!] ${RED}ERROR${NC}: No ROOT password secret provided!"
		kill "$pid" 
		exit 1
	fi

	if [ ! -f "$USER_PW_FILE" ]; then
		printf "%b\n" "${MAG}[!] ${RED}ERROR${NC}: No USER password secret provided!"
		kill "$pid" 
		exit 1
	fi

	root_pw="$(cat "$ROOT_PW_FILE")"
	user_pw="$(cat "$USER_PW_FILE")"

	printf "%b\n" "${MAG}[!]${NC} Applying secure installation steps..."

	mariadb <<- EOF
		-- Set root password
		ALTER USER 'root'@'localhost' IDENTIFIED BY '$root_pw';

		-- Create a remote version of the admin and set passwords for both
		ALTER USER 'mysql'@'localhost' IDENTIFIED BY '$user_pw';
		CREATE USER IF NOT EXISTS 'mysql'@'%' IDENTIFIED BY '$user_pw';

		-- Create a healthcheck user for...healthchecks
		CREATE USER IF NOT EXISTS 'healthcheck'@'localhost';

		-- Remove anonymous users
		DELETE FROM mysql.user WHERE User='';

		-- Disallow remote root login
		DELETE FROM mysql.user WHERE User='root' AND Host!='localhost';

		-- Remove test database
		DROP DATABASE IF EXISTS test;
		DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';

		-- Create wordpress database
		CREATE DATABASE \`$DB_NAME\`;
		GRANT ALL PRIVILEGES ON \`$DB_NAME\`.* TO 'mysql'@'%';
		GRANT USAGE ON \`$DB_NAME\`.* TO 'healthcheck'@'localhost';

		-- Reload privilege tables
		FLUSH PRIVILEGES;
	EOF

	printf "%b\n" "${MAG}[!]${NC} Secure installation complete!"

	# shut down temporary server
	mariadb-admin -uroot -p"$root_pw" shutdown
	wait "$pid"

	printf "%b\n" "${MAG}[!]${NC} First-time setup complete!"
else
	printf "%b\n" "${MAG}[!]${NC} First-time setup skipped..."
fi

exec "$@"
