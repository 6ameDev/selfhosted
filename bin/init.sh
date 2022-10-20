#!/bin/bash

# Load environment variables
source ./.env

# Make users and groups
sudo useradd sonarr -u 13001
sudo useradd radarr -u 13002
sudo useradd lidarr -u 13003
sudo useradd readarr -u 13004
sudo useradd prowlarr -u 13005
sudo useradd qbittorrent -u 13006
sudo useradd jellyfin -u 13007
sudo useradd portainer -u 13008

sudo groupadd mediacenter -g 13000

sudo usermod -a -G mediacenter sonarr
sudo usermod -a -G mediacenter radarr
sudo usermod -a -G mediacenter lidarr
sudo usermod -a -G mediacenter readarr
sudo usermod -a -G mediacenter prowlarr
sudo usermod -a -G mediacenter qbittorrent
sudo usermod -a -G mediacenter jellyfin

# Make directories
sudo mkdir -pv ${DOCKER_CONFIG_DIR}/docker/{sonarr,radarr,lidarr,readarr,prowlarr,qbittorrent,jellyfin,portainer}-config
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
sudo chown -R portainer:portainer ${DOCKER_CONFIG_DIR}/docker/portainer-config

# Export current user's id to UID environment variable
echo "UID=$(id -u)" >> .env
