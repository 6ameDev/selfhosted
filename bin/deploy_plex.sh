#!/bin/bash

# Load base environment variables
source ./.env

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
