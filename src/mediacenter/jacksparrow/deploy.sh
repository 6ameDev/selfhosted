#!/bin/bash

# Load base environment variables
source ./../.env
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
sudo mkdir -pv ${APP_CONFIG_DIR}/{sonarr,radarr,lidarr,readarr,prowlarr,qbittorrent}
sudo mkdir -pv ${STORAGE_DIR}/{torrents,media}/{tv,movies,music,books}

# Set permissions
sudo chmod -R 775 ${STORAGE_DIR}/torrents/
sudo chmod -R 775 ${STORAGE_DIR}/media/
sudo chown -R $(id -u):mediacenter ${STORAGE_DIR}/torrents
sudo chown -R $(id -u):mediacenter ${STORAGE_DIR}/media
sudo chown -R sonarr:mediacenter ${APP_CONFIG_DIR}/sonarr
sudo chown -R radarr:mediacenter ${APP_CONFIG_DIR}/radarr
sudo chown -R lidarr:mediacenter ${APP_CONFIG_DIR}/lidarr
sudo chown -R readarr:mediacenter ${APP_CONFIG_DIR}/readarr
sudo chown -R prowlarr:mediacenter ${APP_CONFIG_DIR}/prowlarr
sudo chown -R qbittorrent:mediacenter ${APP_CONFIG_DIR}/qbittorrent

# Compile options for the required services
options=""
if [ "$ENABLE_SONARR" = true ]; then
    options="${options} -f ./sonarr/docker-compose.yml"
fi
if [ "$ENABLE_RADARR" = true ]; then
    options="${options} -f ./radarr/docker-compose.yml"
fi
if [ "$ENABLE_LIDARR" = true ]; then
    options="${options} -f ./lidarr/docker-compose.yml"
fi
if [ "$ENABLE_READARR" = true ]; then
    options="${options} -f ./readarr/docker-compose.yml"
fi
if [ "$ENABLE_PROWLARR" = true ]; then
    options="${options} -f ./prowlarr/docker-compose.yml"
fi
if [ "$ENABLE_QBITTORRENT" = true ]; then
    options="${options} -f ./qbittorrent/docker-compose.yml"
fi

# Pull latest docker images for all the required services.
docker compose $options pull

# Run Docker Compose to get all the required services up and running.
docker compose --compatibility $options up -d

# Clean up stale docker images
docker image prune -f
