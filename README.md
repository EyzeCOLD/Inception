*This project has been created as part of the 42 curriculum by juaho.*

# Inception

## Description

This project is about setting up a small microservice infrastructure inside a
virtual machine. By using Docker I have setup a blog web page with a database
and a webserver, all running in their own containers.

### Concepts
#### Virtual Machine vs Docker

Whereas a virtual machine emulates the whole computer hardware and runs its own
operating system, a Docker containers are lightweight and share the host 
system's OS kernel, making the resource overhead of Docker containers much lower.

#### Secrets vs Environment Variables

Docker secrets are mounted as files in `/run/secrets/` inside the container. 
This way they are only read once during the setup when they are needed. 
Environment variables are often available to all processes, and it can be 
difficult to track access. They can also be printed in logs when debugging 
errors without your knowledge. Using secrets mitigates these risks.
<br><br>
Even with secrets, you still have the passwords stored in plain text on the 
container, so it is not a perfect solution either.

#### Docker Network vs Host Network

Docker network is a virtual network for the containers to communicate with each 
other whereas host network refers to the host computer's own network (in this 
case the virtual machine). The docker network can be reached from the host 
network by mapping the ports to the host's ports.

#### Docker Volumes vs Bind Mounts

A docker volume is a directory inside the container that you wish persist even 
when the container isn't running, completely managed by Docker. A bind mount is 
a type of docker volume where you specify a directory on the host computer to 
be used as the docker volume, which allows you to mount local files from the 
host on to the container.

## Instructions

#### Prerequisites

* Git
* Bash (for `env-setup.sh` and `secret-setup.sh`)
* Make
* Docker

#### Setup steps

1. `git clone` this repository
2. Run the scripts `./env-setup.sh` and `./secret-setup.sh` in the root 
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

## Resources

* [Alpine Linux wiki](https://wiki.alpinelinux.org/wiki/Main_Page)
* [Docker Documentation](https://docs.docker.com/)
* [MariaDB Documentation](https://mariadb.org/documentation/)
* [Nginx Documentation](https://nginx.org/en/docs/)
* [WP-CLI Handbook](https://make.wordpress.org/cli/handbook/)
* [PHP Manual](https://www.php.net/manual/en/index.php)

#### AI use

AI (ChatGPT) was used mainly in two ways during the project:
1. As troubleshooting help, for example when a specific error message didn't 
yield results on a Google search
2. To figure out best practices in bulding Docker images
