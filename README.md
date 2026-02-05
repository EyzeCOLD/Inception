*This project has been created as part of the 42 curriculum by juaho.*

# Inception

## Description

This project is about setting up a small microservice infrastructure inside a
virtual machine. By using Docker I have setup a blog web page with a database
and a webserver, all running in their own containers.

## Instructions

Docker, Git, Bash and Make are required to run the app.
1. `git clone` the repository
2. Run `env-setup.sh` and `secret-setup.sh` to setup the environment variable and the passwords
3. In the root folder of the project run `make`
4. Wordpress should now be accessible via URL given in `env-setup.sh` through https

* `make`          - build the images, create the volumes and start the app
* `make up`       - same as `make`
* `make logs`     - show docker compose logs
* `make down`     - shut down the application
* `make clean`    - shut down and remove all docker images
* `make fclean`   - same as clean, but also removes local volumes, requires sudo
* `make re`       - `make fclean` + `make`
