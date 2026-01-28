#!/bin/sh
RED="\033[31m"
MAG="\033[35m"
NC="\033[0m"

set -e

MARIADB_PW_FILE="/run/secrets/mariadb_user_pw"
WP_ADMIN_PW_FILE="/run/secrets/wp_admin_pw"

if [ ! -f /var/www/html/wp-config.php ]; then
	printf "%b\n" "${MAG}[!]${NC} Running first-time WordPress setup via WP-CLI..."

	if [ ! -f "$WP_ADMIN_PW_FILE" ]; then
		printf "%b\n" "${MAG}[!] ${RED}ERROR${NC}: No WP_ADMIN password secret provided!"
		exit 1
	fi

	if [ ! -f "$MARIADB_PW_FILE" ]; then
		printf "%b\n" "${MAG}[!] ${RED}ERROR${NC}: No MARIADB password secret provided!"
		exit 1
	fi

	WP_ADMIN_PW=$(cat ${WP_ADMIN_PW})
	MARIADB_PW=$(cat ${MARIADB_PW_FILE})

	echo "wp core download..."
	wp core download --path=wp-files
	cd wp-files
	echo "wp config create..."
	wp config create \
		--dbname="${DB_NAME}" \
		--dbuser=mysql \
		--prompt="${MARIADB_PW}"
	echo "wp db create..."
	wp db create
	echo "wp core install..."
	wp core install \
		--url="${WP_ULR}" \
		--title="${WP_TITLE}" \
		--admin_user="${WP_ADMIN}" \
		--admin_password="${WP_ADMIN_PW}" \
		--admin_email="${WP_ADMIN_EMAIL}"

	printf "%b\n" "${MAG}[!]${NC} First-time WordPress setup via WP-CLI complete!"
else
	printf "%b\n" "${MAG}[!]${NC} First-time WordPress setup skipped..."
fi


exec "$@"
