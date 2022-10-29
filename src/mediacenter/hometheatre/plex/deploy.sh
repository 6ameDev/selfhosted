#!/bin/bash

# Load base environment variables
source ./../../.env

# Make directories
sudo mkdir -pv ${APP_CONFIG_DIR}/plex

# Set permissions
sudo chown -R $(id -u):mediacenter ${APP_CONFIG_DIR}/plex

# Export current user's id to UID environment variable
echo "UID=$(id -u)" >> .env

# Pull latest docker images for all the required services.
docker compose pull

# Run Docker Compose to get all the required services up and running.
docker compose --compatibility up -d

# Clean up stale docker images
docker image prune -f

# Deploy docker stack hometheatre based on plex
# docker stack deploy -c docker-compose-stack.yml hometheatre
