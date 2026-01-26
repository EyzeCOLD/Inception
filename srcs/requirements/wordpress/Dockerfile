FROM alpine:3.22

RUN apk update && apk add --no-cache \
		php84 \
		php84-fpm \
		curl

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN chmod +x wp-cli.phar

ENTRYPOINT ["wpsetup.sh"]
# CMD []
