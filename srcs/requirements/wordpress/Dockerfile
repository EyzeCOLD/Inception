FROM alpine:3.22

RUN apk update && apk add --no-cache \
		php84 \
		php84-cli \
		php84-curl \
		php84-fpm \
		php84-iconv \
		php84-json \
		php84-mysqli \
		php84-openssl \
		php84-phar \
		curl

# Wordpress installation relies on "php" being in PATH and some PHP packages don't create the symlink
RUN ln -sf /usr/bin/php84 /usr/bin/php

COPY config /etc/php84/php-fpm.d/www.conf
COPY ini /etc/php84/conf.d/00-wp.ini
COPY setup.sh /usr/local/bin
RUN chmod +x /usr/local/bin/setup.sh

# Get WP-CLI and add it to a directory already in PATH
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

# Create web user
RUN adduser -D -H -g 'www' www
RUN mkdir -p /www
RUN chown -R www:www /www

ENTRYPOINT ["setup.sh"]
CMD ["php-fpm84", "-F"]
