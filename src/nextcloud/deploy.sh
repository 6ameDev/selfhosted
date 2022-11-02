#!/bin/bash

# Load base environment variables
source ./../.env

# Make directories
sudo mkdir -pv ${APP_CONFIG_DIR}/{nextcloud,postgres}

# Set permissions
sudo chown -R $(id -u):$(id -u) ${APP_CONFIG_DIR}/nextcloud
sudo chown -R $(id -u):$(id -u) ${APP_CONFIG_DIR}/postgres

# Pull latest docker images for all the required services.
docker compose pull

# Run Docker Compose to get all the required services up and running.
docker compose --compatibility up -d

# Clean up stale docker images
docker image prune -f
