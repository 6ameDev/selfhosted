#!/bin/bash

# Load base environment variables
source ./.env

####################
## JackSparrow Stack
####################
./bin/deploy_jacksparrow.sh

###########
## JELLYFIN
###########

# Export host machine's IP to environment variable
hostIp=$(hostname -I | cut -d ' ' -f1)
echo "Adding host ip ${hostIp} to env file"
echo "HOST_IP=${hostIp}" >> .env

# Make directories
sudo mkdir -pv ${APP_CONFIG_DIR}/jellyfin

# Set permissions
sudo chown -R $(id -u):mediacenter ${APP_CONFIG_DIR}/jellyfin

# Export current user's id to UID environment variable
echo "UID=$(id -u)" >> .env

compose_file_path=src/mediacenter/hometheatre/jellyfin/docker-compose.yml

# Pull latest docker images for all the required services.
docker compose -f $compose_file_path --env-file .env pull

# Run Docker Compose to get all the required services up and running.
docker compose --compatibility -f $compose_file_path --env-file .env up -d

#######
## PLEX
#######

# Make directories
sudo mkdir -pv ${APP_CONFIG_DIR}/plex

# Set permissions
sudo chown -R $(id -u):mediacenter ${APP_CONFIG_DIR}/plex

# Export current user's id to UID environment variable
echo "UID=$(id -u)" >> .env

compose_file_path=src/mediacenter/hometheatre/plex/docker-compose.yml

# Pull latest docker images for all the required services.
docker compose -f $compose_file_path --env-file .env pull

# Run Docker Compose to get all the required services up and running.
docker compose --compatibility -f $compose_file_path --env-file .env up -d
