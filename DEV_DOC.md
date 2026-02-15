# Developer Documentation

#### Prerequisites

* Git
* Bash (for `env-setup.sh` and `secret-setup.sh`)
* Make
* Docker

#### Setup steps

1. `git clone` this repository
2. Run the scripts `./env-setup.sh` and `./secret-setup.sh` in the rood 
directory of the repository
3. After the .env file and the secrets are setup, run`make`
4. Wordpress should now be accessible via URL given in `env-setup.sh` (HTTPS)

#### Make commands

* `make`          - build the images, create the volumes and start the app
* `make up`       - same as `make`
* `make logs`     - show docker compose logs
* `make down`     - shut down the application
* `make clean`    - shut down and remove all docker images
* `make fclean`   - same as clean, but also removes local volumes, requires sudo
* `make re`       - `make fclean` + `make`

#### Docker Compose

The Makefile at the root of directory mostly just forwards commands to Docker 
Compose. If you want to use more Docker commands, you can find 
`docker-compose.yml` in `/srcs/` inside the repository. For Docker commands 
beyond what is already in the Makefile, consult Docker's own documentation
(see **Resources** in README.md).

#### Docker volumes

This application uses two bind mounts to store data when the containers are 
down. The default directory for this persistent data is `~/data/`. You can 
change this in `docker-compose.yml`. The database's local volume will require 
`sudo` rights to remove.
