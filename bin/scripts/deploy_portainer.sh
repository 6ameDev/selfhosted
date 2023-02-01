#!/bin/bash

# Load base environment variables
source ./.env

# Make users and groups
sudo useradd portainer -u 13200 &>/dev/null

# Make directories
sudo mkdir -pv ${APP_CONFIG_DIR}/portainer

# Set permissions
sudo chown -R portainer:portainer ${APP_CONFIG_DIR}/portainer

compose_file_path=src/tools/portainer/docker-compose.yml

# Pull latest docker images for all the required services.
docker compose -f $compose_file_path --env-file .env pull

# Run Docker Compose to get all the required services up and running.
docker compose --compatibility -f $compose_file_path --env-file .env up -d
