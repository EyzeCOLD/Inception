FROM alpine:3.22

RUN apk update && apk add --no-cache nginx

RUN adduser -D -g 'www' www
RUN mkdir /www
RUN chown -R www:www /var/lib/nginx
RUN chown -R www:www /www

COPY nginx.conf /etc/nginx/http.d/default.conf
COPY index.html /www/index.html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

