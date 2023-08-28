#!/bin/bash

# Load base environment variables
source ./.env

# Make users and groups
sudo groupadd mediacenter -g 13000 &>/dev/null

sudo useradd sonarr -u 13001 &>/dev/null
sudo useradd radarr -u 13002 &>/dev/null
sudo useradd lidarr -u 13003 &>/dev/null
sudo useradd readarr -u 13004 &>/dev/null
sudo useradd prowlarr -u 13005 &>/dev/null

sudo useradd qbittorrent -u 13100 &>/dev/null

sudo usermod -a -G mediacenter sonarr
sudo usermod -a -G mediacenter radarr
sudo usermod -a -G mediacenter lidarr
sudo usermod -a -G mediacenter readarr
sudo usermod -a -G mediacenter prowlarr
sudo usermod -a -G mediacenter qbittorrent

# Make directories
sudo mkdir -pv ${APP_CONFIG_DIR}/{sonarr,radarr,lidarr,readarr,prowlarr,qbittorrent}
sudo mkdir -pv ${MEDIA_ONE_DIR}/{torrents,media}/{movies,music,books}
sudo mkdir -pv ${MEDIA_TWO_DIR}/{torrents,media}/{tv}

# Set permissions
sudo chmod -R 775 ${MEDIA_ONE_DIR}/torrents/
sudo chmod -R 775 ${MEDIA_ONE_DIR}/media/
sudo chown -R $(id -u):mediacenter ${MEDIA_ONE_DIR}/torrents
sudo chown -R $(id -u):mediacenter ${MEDIA_ONE_DIR}/media

sudo chmod -R 775 ${MEDIA_TWO_DIR}/torrents/
sudo chmod -R 775 ${MEDIA_TWO_DIR}/media/
sudo chown -R $(id -u):mediacenter ${MEDIA_TWO_DIR}/torrents
sudo chown -R $(id -u):mediacenter ${MEDIA_TWO_DIR}/media

sudo chown -R sonarr:mediacenter ${APP_CONFIG_DIR}/sonarr
sudo chown -R radarr:mediacenter ${APP_CONFIG_DIR}/radarr
sudo chown -R lidarr:mediacenter ${APP_CONFIG_DIR}/lidarr
sudo chown -R readarr:mediacenter ${APP_CONFIG_DIR}/readarr
sudo chown -R prowlarr:mediacenter ${APP_CONFIG_DIR}/prowlarr
sudo chown -R qbittorrent:mediacenter ${APP_CONFIG_DIR}/qbittorrent

# Compile options for the required services
options=""
if [ "$ENABLE_SONARR" = true ]; then
    options="${options} -f src/mediacenter/jacksparrow/sonarr/docker-compose.yml"
fi
if [ "$ENABLE_RADARR" = true ]; then
    options="${options} -f src/mediacenter/jacksparrow/radarr/docker-compose.yml"
fi
if [ "$ENABLE_LIDARR" = true ]; then
    options="${options} -f src/mediacenter/jacksparrow/lidarr/docker-compose.yml"
fi
if [ "$ENABLE_READARR" = true ]; then
    options="${options} -f src/mediacenter/jacksparrow/readarr/docker-compose.yml"
fi
if [ "$ENABLE_PROWLARR" = true ]; then
    options="${options} -f src/mediacenter/jacksparrow/prowlarr/docker-compose.yml"
fi
if [ "$ENABLE_QBITTORRENT" = true ]; then
    options="${options} -f src/mediacenter/jacksparrow/qbittorrent/docker-compose.yml"
fi

# Pull latest docker images for all the required services.
docker compose $options --env-file .env pull

# Run Docker Compose to get all the required services up and running.
docker compose --compatibility $options --env-file .env up -d
