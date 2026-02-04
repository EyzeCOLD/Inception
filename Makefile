NAME		:= inception

COMPOSE		:= docker compose -f srcs/docker-compose.yml

DATADIR		:= $(HOME)/data

all: data_dirs
	make up

data_dirs:
	mkdir -p $(DATADIR)
	mkdir -p $(DATADIR)/wordpress_data
	mkdir -p $(DATADIR)/mariadb_data

up:
	$(COMPOSE) up --build

down:
	$(COMPOSE) down

clean:
	$(COMPOSE) down --rmi all

fclean: clean
	$(COMPOSE) down --volumes
	# need sudo to remove mariadb_data as it has weird privileges due to bind
	sudo rm -rf $(DATADIR)

re: fclean
	make all

.PHONY: all up down clean fclean re
