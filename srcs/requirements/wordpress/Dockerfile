FROM alpine:3.22

RUN apk update && apk add --no-cache \
		php83 \
		php83-curl \
		php83-fpm \
		php83-json \
		php83-mysqli \
		php83-openssl \
		php83-phar \
		curl

COPY www.conf /etc/php83/php-fpm.d/www.conf
COPY wp.ini /etc/php83/conf.d/00-wp.ini

# get WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
# put it into PATH as wp
RUN mv wp-cli.phar /usr/local/bin/wp

COPY wp_setup.sh /usr/local/bin
RUN chmod +x /usr/local/bin/wp_setup.sh

ENTRYPOINT ["wp_setup.sh"]
CMD ["php-fpm84", "-F"]
