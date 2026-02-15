# User Documentation

## Services provided

* Wordpress
* Nginx
* MariaDB

## Starting and stopping the project

Before running make, make sure to run `secret-setup.sh` and `env-setup.sh` to generate the necessary files.
<br><br>
To run the make commands, go to the root of the project in terminal
* `make`          - build the images, create the volumes and start the app
* `make up`       - same as `make`
* `make logs`     - show docker compose logs
* `make down`     - shut down the application
* `make clean`    - shut down and remove all docker images
* `make fclean`   - same as clean, but also removes local volumes, requires sudo
* `make re`       - `make fclean` + `make`

## Accessing the website and the administration panel

The website will be available in the url set in the .env file at the time you build the containers the first time. In order for the URL to resolve to the IP address of the server, you need to either own the domain or locally just `/etc/hosts`
<br><br>
To reach the admin panel, enter `/wp-login` after the chosen URL, like `https://juaho.42.fr/wp-login`

## Credentials

Credentials are managed with `secret-setup.sh` and `env-setup.sh` scripts that you *have to run with Bash*. They are then stored into `srcs/secrets/` and `srcs/.env` respectively where you can edit them manually.

## Diagnostics

You can use various docker commands to diagnose the state of the containers. While in the `srcs/` folder with `docker-compose.yml`
* `docker compose ps` - shows you the state of all the containers
* `docker compose logs` - shows you the logs from the build (same as `make logs` mentioned previously)
