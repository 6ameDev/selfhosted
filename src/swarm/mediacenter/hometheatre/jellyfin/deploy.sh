#!/bin/bash

# Load base environment variables
source ./../../.env

# Make directories
sudo mkdir -pv ${APP_CONFIG_DIR}/jellyfin

# Set permissions
sudo chown -R $(id -u):mediacenter ${APP_CONFIG_DIR}/jellyfin

# Export current user's id to UID environment variable
echo "UID=$(id -u)" >> .env

# Deploy docker stack hometheatre based on plex
docker stack deploy -c docker-compose-stack.yml hometheatre
