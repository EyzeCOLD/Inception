NAME		:= inception

COMPOSE		:= docker compose -f srcs/docker-compose.yml

DATADIR		:= $(HOME)/data

all:
	make up

data_dirs:
	mkdir -p $(DATADIR)
	mkdir -p $(DATADIR)/wordpress_data
	mkdir -p $(DATADIR)/mariadb_data

up: data_dirs
	$(COMPOSE) up -d --build
	@echo "Job's done!"

logs:
	$(COMPOSE) logs

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

.PHONY: all up down clean fclean re log
