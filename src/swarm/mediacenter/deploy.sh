#!/bin/bash

# Load base environment variables
source ./../../.env

# Make users and groups
sudo groupadd mediacenter -g 13000

# Make directories
sudo mkdir -pv ${STORAGE_DIR}/{torrents,media}/{tv,movies,music,books}

# Set permissions
sudo chmod -R 775 ${STORAGE_DIR}/torrents/
sudo chmod -R 775 ${STORAGE_DIR}/media/
sudo chown -R $(id -u):mediacenter ${STORAGE_DIR}/torrents
sudo chown -R $(id -u):mediacenter ${STORAGE_DIR}/media
