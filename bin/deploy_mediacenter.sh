#!/bin/bash

# Load base environment variables
source ./.env

# Make users and groups
sudo groupadd mediacenter -g 13000

sudo useradd sonarr -u 13001
sudo useradd radarr -u 13002
sudo useradd lidarr -u 13003
sudo useradd readarr -u 13004
sudo useradd prowlarr -u 13005

sudo useradd qbittorrent -u 13100

sudo usermod -a -G mediacenter sonarr
sudo usermod -a -G mediacenter radarr
sudo usermod -a -G mediacenter lidarr
sudo usermod -a -G mediacenter readarr
sudo usermod -a -G mediacenter prowlarr
sudo usermod -a -G mediacenter qbittorrent

# Make directories
sudo mkdir -pv ${STORAGE_DIR}/{torrents,media}/{tv,movies,music,books}

# Set permissions
sudo chmod -R 775 ${STORAGE_DIR}/torrents/
sudo chmod -R 775 ${STORAGE_DIR}/media/
sudo chown -R $(id -u):mediacenter ${STORAGE_DIR}/torrents
sudo chown -R $(id -u):mediacenter ${STORAGE_DIR}/media

## JELLYFIN
# Make directories
sudo mkdir -pv ${APP_CONFIG_DIR}/jellyfin

# Set permissions
sudo chown -R $(id -u):mediacenter ${APP_CONFIG_DIR}/jellyfin

# Export current user's id to UID environment variable
echo "UID=$(id -u)" >> .env

# Pull latest docker images for all the required services.
docker compose pull

# Run Docker Compose to get all the required services up and running.
docker compose --compatibility up -d

## PLEX
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
