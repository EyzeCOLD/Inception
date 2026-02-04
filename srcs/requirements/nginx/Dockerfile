FROM alpine:3.22

RUN apk update && apk add --no-cache \
	nginx \
	openssl

RUN mkdir -p /etc/nginx/ssl
RUN openssl req -x509 \
-newkey rsa:4096 \
-keyout /etc/nginx/ssl/certificate.key \
-out /etc/nginx/ssl/certificate.crt \
-sha256 \
-days 3650 \
-nodes \
-subj "/C=FI/ST=Uusimaa/L=Helsinki/O=EyzeCo/OU=EyzeUnit/CU=$WP_URL"

RUN adduser -D -H -g 'www' www
RUN mkdir -p /www
RUN chown -R www:www /var/lib/nginx
RUN chown -R www:www /www

COPY config /etc/nginx/http.d/default.conf

CMD ["nginx", "-g", "daemon off;"]

