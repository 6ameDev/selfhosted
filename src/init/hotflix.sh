#!/bin/bash

# Load environment variables
source ./deploy.env

# Create hotflix group and user
sudo groupadd -g 13000 hotflix
sudo useradd -r -u 13000 -g hotflix -s /usr/sbin/nologin hotflix

# Create hotflix directories
sudo mkdir -pv ${APP_CONFIG_DIR}/hotflix/{jellyfin,sonarr,radarr,prowlarr,qbittorrent}

# Set ownership of all directories in hotflix
sudo chown -R hotflix:hotflix ${APP_CONFIG_DIR}/hotflix

# Set permissions for all directories in hotflix
sudo chmod -R 750 ${APP_CONFIG_DIR}/hotflix
