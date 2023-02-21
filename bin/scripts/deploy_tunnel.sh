#!/bin/bash

# Load base environment variables
source ./.env

# Make directories
sudo mkdir -pv ${APP_CONFIG_DIR}/tunnel/{primary,secondary}

# Set permissions
sudo chown -R 65532:65532 ${APP_CONFIG_DIR}/tunnel

compose_file_path=src/tools/tunnel/docker-compose.yml

# Pull latest docker images for all the required services.
docker compose -f $compose_file_path --env-file .env pull

# Run Docker Compose to get all the required services up and running.
docker compose --compatibility -f $compose_file_path --env-file .env up -d
