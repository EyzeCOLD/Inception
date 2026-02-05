#!/bin/bash
set -e

echo "****************************"
echo "* Welcome to the env setup *"
echo "****************************"

if [ -f "./srcs/.env" ]; then
	echo "WARNING: \"./srcs/.env\" already exists."
	echo "CTRL+C if you do not wish to overwrite"
fi

read -e -p "Database Name: "  db_name

read -e -p "Wordpress Page Title: " wp_title

read -e -p "Wordpress URL: " wp_url

read -e -p "Wordpress Admin username: " wp_admin

read -e -p "Wordpress Admin email: " wp_admin_email

read -e -p "Wordpress User username: " wp_user

read -e -p "Wordpress User email: " wp_user_email

echo -e "DB_NAME=$db_name\n
WP_TITLE=$wp_title\n
WP_URL=$wp_url\n
WP_ADMIN=$wp_admin\n
WP_ADMIN_EMAIL=$wp_admin_email\n
WP_USER=$wp_user\n
WP_USER_EMAIL=$wp_user_email\n" > ./srcs/.env

echo ".env created!"
