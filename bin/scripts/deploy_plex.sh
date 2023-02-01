#!/bin/bash

# Load base environment variables
source ./.env

# UID will be appended to the temporary docker.env file
# Adding to .env and sourcing it will give warning
cp .env docker.env

# Make directories
sudo mkdir -pv ${APP_CONFIG_DIR}/plex

# Set permissions
sudo chown -R $(id -u):mediacenter ${APP_CONFIG_DIR}/plex

# Export current user's id to UID environment variable
echo "UID=$(id -u)" >> docker.env

compose_file_path=src/mediacenter/hometheatre/plex/docker-compose.yml

# Pull latest docker images for all the required services.
docker compose -f $compose_file_path --env-file docker.env pull

# Run Docker Compose to get all the required services up and running.
docker compose --compatibility -f $compose_file_path --env-file docker.env up -d

rm docker.env
