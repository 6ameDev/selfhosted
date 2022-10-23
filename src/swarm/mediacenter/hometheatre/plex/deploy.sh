#!/bin/bash

# Load base environment variables
source ./../../.env

# Make users and groups
sudo groupadd mediacenter -g 13000

# Make directories
sudo mkdir -pv ${APP_CONFIG_DIR}/plex
sudo mkdir -pv ${STORAGE_DIR}/{torrents,media}/{tv,movies,music,books}

# Set permissions
sudo chmod -R 775 ${MEDIA_DIR}/data/
sudo chown -R $(id -u):mediacenter ${STORAGE_DIR}/torrents
sudo chown -R $(id -u):mediacenter ${STORAGE_DIR}/media
sudo chown -R $(id -u):mediacenter ${APP_CONFIG_DIR}/plex

# Export current user's id to UID environment variable
echo "UID=$(id -u)" >> .env

# Deploy docker stack hometheatre based on plex
docker stack deploy -c docker-compose-stack.yml hometheatre