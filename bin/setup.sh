#!/bin/bash

# Make users and groups
sudo useradd sonarr -u 13001
sudo useradd radarr -u 13002
sudo useradd lidarr -u 13003
sudo useradd readarr -u 13004
sudo useradd prowlarr -u 13005
sudo useradd qbittorrent -u 13006
sudo useradd jellyfin -u 13007

sudo groupadd mediacenter -g 13000

sudo usermod -a -G mediacenter sonarr
sudo usermod -a -G mediacenter radarr
sudo usermod -a -G mediacenter lidarr
sudo usermod -a -G mediacenter readarr
sudo usermod -a -G mediacenter prowlarr
sudo usermod -a -G mediacenter qbittorrent
sudo usermod -a -G mediacenter jellyfin

# Make directories
sudo mkdir -pv ${DOCKER_CONFIG_DIR}/docker/{sonarr,radarr,lidarr,readarr,prowlarr,qbittorrent,jellyfin}-config
sudo mkdir -pv ${DATA_DIR}/data/{torrents,media}/{tv,movies,music,books}

# Set permissions
sudo chmod -R 775 ${DATA_DIR}/data/
sudo chown -R $(id -u):mediacenter ${DATA_DIR}/data/
sudo chown -R sonarr:mediacenter ${DOCKER_CONFIG_DIR}/docker/sonarr-config
sudo chown -R radarr:mediacenter ${DOCKER_CONFIG_DIR}/docker/radarr-config
sudo chown -R lidarr:mediacenter ${DOCKER_CONFIG_DIR}/docker/lidarr-config
sudo chown -R readarr:mediacenter ${DOCKER_CONFIG_DIR}/docker/readarr-config
sudo chown -R prowlarr:mediacenter ${DOCKER_CONFIG_DIR}/docker/prowlarr-config
sudo chown -R qbittorrent:mediacenter ${DOCKER_CONFIG_DIR}/docker/qbittorrent-config
sudo chown -R jellyfin:mediacenter ${DOCKER_CONFIG_DIR}/docker/jellyfin-config

# Export current user's id to UID environment variable
echo "UID=$(id -u)" >> .env

# Run Docker Compose to get all the required services up and running.
# Uncomment the lines for the services you require.

# docker-compose -f ./../src/sonarr/docker-compose.yml up -d          # Bring up Sonarr container
# docker-compose -f ./../src/radarr/docker-compose.yml up -d          # Bring up Radarr container
# docker-compose -f ./../src/lidarr/docker-compose.yml up -d          # Bring up Lidarr container
# docker-compose -f ./../src/readarr/docker-compose.yml up -d         # Bring up Readarr container
# docker-compose -f ./../src/prowlarr/docker-compose.yml up -d        # Bring up Prowlarr container
# docker-compose -f ./../src/qbittorrent/docker-compose.yml up -d     # Bring up QBitTorrent container
# docker-compose -f ./../src/jellyfin/docker-compose.yml up -d        # Bring up Jellyfin container