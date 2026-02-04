FROM alpine:3.22

RUN apk update && apk add --no-cache mariadb mariadb-client

# Create socket dir
RUN mkdir -p /run/mysqld && chown mysql:mysql /run/mysqld

COPY config /etc/my.cnf.d/mariadb-server.cnf
COPY setup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/setup.sh

ENTRYPOINT ["setup.sh"]
CMD ["/usr/bin/mariadbd", "--user=mysql", "--datadir=/var/lib/mysql", "--console"]
