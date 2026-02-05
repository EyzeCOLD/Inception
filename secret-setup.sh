#!/bin/bash

echo "***************************"
echo "* Welcome to secret setup *"
echo "***************************"

if [ -d "./srcs/secrets/" ]; then
	echo "WARNING: ./srcs/secrets/ folder already exists."
	echo "CTRL+C if you do not wish to overwrite the secrets."
fi

read -e -s -p "MariaDB root password: " mariadb_root_pw
read -e -s -p "MariaDB root password again: " mariadb_root_pw2
if [ ! "x$mariadb_root_pw" = "x$mariadb_root_pw2" ]; then
	echo "Passwords don't match"
	exit 1
fi

read -e -s -p "MariaDB user password: " mariadb_user_pw
read -e -s -p "MariaDB user password again: " mariadb_user_pw2
if [ ! "x$mariadb_user_pw" = "x$mariadb_user_pw2" ]; then
	echo "Passwords don't match"
	exit 1
fi

read -e -s -p "Wordpress admin password: " wp_admin_pw
read -e -s -p "Wordpress admin password again: " wp_admin_pw2
if [ ! "x$wp_admin_pw" = "x$wp_admin_pw2" ]; then
	echo "Passwords don't match"
	exit 1
fi

read -e -s -p "Wordpress user password: " wp_user_pw
read -e -s -p "Wordpress user password again: " wp_user_pw2
if [ ! "x$wp_user_pw" = "x$wp_user_pw2" ]; then
	echo "Passwords don't match"
	exit 1
fi

mkdir -p ./srcs/secrets
echo "$mariadb_root_pw" > ./srcs/secrets/mariadb_root_pw.txt
echo "$mariadb_user_pw" > ./srcs/secrets/mariadb_user_pw.txt
echo "$wp_admin_pw" > ./srcs/secrets/wp_admin_pw.txt
echo "$wp_user_pw" > ./srcs/secrets/wp_user_pw.txt
echo "/secrets/ folder created with secrets. Secret!"
