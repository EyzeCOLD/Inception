FROM alpine:3.22

# Install
RUN apk update && apk add --no-cache mariadb mariadb-client

# socket dir
RUN mkdir -p /run/mysqld && chown mysql:mysql /run/mysqld

# config
COPY conf /etc/my.cnf.d/mariadb-server.cnf

# setup script
COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 3306

ENTRYPOINT ["entrypoint.sh"]
CMD ["/usr/bin/mariadbd", "--user=mysql", "--datadir=/var/lib/mysql", "--console"]
