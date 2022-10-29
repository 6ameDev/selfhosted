#!/bin/bash

# Load base environment variables
source ./../../.env

# Make users and groups
sudo useradd portainer -u 13200

# Make directories
sudo mkdir -pv ${APP_CONFIG_DIR}/portainer

# Set permissions
sudo chown -R portainer:portainer ${APP_CONFIG_DIR}/portainer

# Pull latest docker images for all the required services.
docker compose pull

# Run Docker Compose to get all the required services up and running.
docker compose --compatibility up -d

# Clean up stale docker images
docker image prune -f
