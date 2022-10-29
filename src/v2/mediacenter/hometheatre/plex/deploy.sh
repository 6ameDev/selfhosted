#!/bin/bash

# Load base environment variables
source ./../../.env

# Make directories
sudo mkdir -pv ${APP_CONFIG_DIR}/plex

# Set permissions
sudo chown -R $(id -u):mediacenter ${APP_CONFIG_DIR}/plex

# Export current user's id to UID environment variable
echo "UID=$(id -u)" >> .env

# Deploy docker container
# docker compose up -d

# Deploy docker stack hometheatre based on plex
# docker stack deploy -c docker-compose-stack.yml hometheatre
