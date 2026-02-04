#!/bin/sh
RED="\033[31m"
MAG="\033[35m"
NC="\033[0m"

set -e

MARIADB_PW_FILE="/run/secrets/mariadb_user_pw"
WP_ADMIN_PW_FILE="/run/secrets/wp_admin_pw"
WP_USER_PW_FILE="/run/secrets/wp_user_pw"

chown -R www:www /www
cd /www

if [ ! -f wp-config.php ]; then
	printf "%b\n" "${MAG}[!]${NC} Running first-time WordPress setup via WP-CLI..."

	if [ ! -f "$WP_ADMIN_PW_FILE" ]; then
		printf "%b\n" "${MAG}[!] ${RED}ERROR${NC}: No WP_ADMIN password secret provided!"
		exit 1
	fi

	if [ ! -f "$MARIADB_PW_FILE" ]; then
		printf "%b\n" "${MAG}[!] ${RED}ERROR${NC}: No MARIADB password secret provided!"
		exit 1
	fi

	WP_ADMIN_PW=$(cat ${WP_ADMIN_PW_FILE})
	WP_USER_PW=$(cat ${WP_USER_PW_FILE})
	MARIADB_PW=$(cat ${MARIADB_PW_FILE})

	printf "%b\n" "${MAG}[!]${NC} wp core download..."
	wp core download --allow-root

	printf "%b\n" "${MAG}[!]${NC} wp config create..."
	wp config create \
		--allow-root \
		--dbname="${DB_NAME}" \
		--dbuser=mysql \
		--dbpass="${MARIADB_PW}" \
		--dbhost=mariadb:3306

	printf "%b\n" "${MAG}[!]${NC} wp core install..."
	wp core install \
		--allow-root \
		--url="${WP_URL}" \
		--title="${WP_TITLE}" \
		--admin_user="${WP_ADMIN}" \
		--admin_password="${WP_ADMIN_PW}" \
		--admin_email="${WP_ADMIN_EMAIL}"

	printf "%b\n" "${MAG}[!]${NC} wp user create..."
	wp user create \
		${WP_USER} \
		${WP_USER_EMAIL} \
		--path=/www \
		--user_pass=${WP_USER_PW}

	printf "%b\n" "${MAG}[!]${NC} First-time WordPress setup via WP-CLI complete!"
else
	printf "%b\n" "${MAG}[!]${NC} First-time WordPress setup skipped..."
fi

# Give ownership to all the wordpress files to www with recursive chown
chown -R www:www /www

exec "$@"
