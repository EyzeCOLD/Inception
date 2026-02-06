FROM alpine:3.22

RUN apk update && apk add --no-cache \
	nginx \
	openssl \
	gettext

RUN adduser -D -H -g 'www' www
RUN mkdir -p /www
RUN chown -R www:www /var/lib/nginx
RUN chown -R www:www /www

COPY config.template /etc/nginx/templates/config.template
COPY setup.sh /usr/local/bin
RUN chmod u+x /usr/local/bin/setup.sh

ENTRYPOINT ["setup.sh"]
CMD ["nginx", "-g", "daemon off;"]

