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
sudo useradd portainer -u 13007

sudo groupadd mediacenter -g 13000

sudo usermod -a -G mediacenter sonarr
sudo usermod -a -G mediacenter radarr
sudo usermod -a -G mediacenter lidarr
sudo usermod -a -G mediacenter readarr
sudo usermod -a -G mediacenter prowlarr
sudo usermod -a -G mediacenter qbittorrent

# Make directories
sudo mkdir -pv ${APP_CONFIG_DIR}/{sonarr,radarr,lidarr,readarr,prowlarr,qbittorrent,jellyfin,plex,portainer,pihole,nginx}
sudo mkdir -pv ${STORAGE_DIR}/{torrents,media}/{tv,movies,music,books}

# Set permissions
sudo chmod -R 775 ${STORAGE_DIR}/torrents/
sudo chmod -R 775 ${STORAGE_DIR}/media/
sudo chown -R $(id -u):mediacenter ${STORAGE_DIR}/torrents/
sudo chown -R $(id -u):mediacenter ${STORAGE_DIR}/media/
sudo chown -R $(id -u):mediacenter ${APP_CONFIG_DIR}/jellyfin
sudo chown -R $(id -u):mediacenter ${APP_CONFIG_DIR}/plex
sudo chown -R sonarr:mediacenter ${APP_CONFIG_DIR}/sonarr
sudo chown -R radarr:mediacenter ${APP_CONFIG_DIR}/radarr
sudo chown -R lidarr:mediacenter ${APP_CONFIG_DIR}/lidarr
sudo chown -R readarr:mediacenter ${APP_CONFIG_DIR}/readarr
sudo chown -R prowlarr:mediacenter ${APP_CONFIG_DIR}/prowlarr
sudo chown -R qbittorrent:mediacenter ${APP_CONFIG_DIR}/qbittorrent
sudo chown -R portainer:portainer ${APP_CONFIG_DIR}/portainer

sudo chown -R $(id -u):$(id -u) ${APP_CONFIG_DIR}/pihole
sudo chown -R $(id -u):$(id -u) ${APP_CONFIG_DIR}/nginx

# Export current user's id to UID environment variable
echo "UID=$(id -u)" >> .env
