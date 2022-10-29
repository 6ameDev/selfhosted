#!/bin/bash

# Load base environment variables
source ./../.env

# Make users and groups
sudo useradd portainer -u 13200

# Make directories
sudo mkdir -pv ${APP_CONFIG_DIR}/portainer

# Set permissions
sudo chown -R portainer:portainer ${APP_CONFIG_DIR}/portainer

# Deploy docker container
docker compose up -d
