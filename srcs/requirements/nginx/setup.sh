#!/bin/sh
set -e

printf "\033[35m[!]\033[0m Starting Nginx setup..."

mkdir -p /etc/nginx/ssl
openssl req -x509 \
-newkey rsa:4096 \
-keyout /etc/nginx/ssl/certificate.key \
-out /etc/nginx/ssl/certificate.crt \
-sha256 \
-days 3650 \
-nodes \
-subj "/C=FI/ST=Uusimaa/L=Helsinki/O=EyzeCo/OU=EyzeUnit/CU={$WP_URL}"

mkdir -p /etc/nginx/conf.d/
envsubst '$WP_URL' < /etc/nginx/templates/config.template > /etc/nginx/http.d/default.conf

printf "\033[35m[!]\033[0m Nginx setup complete!"

exec "$@"
