#!/bin/bash

# Load base environment variables
source ./.env

## Make directories
sudo mkdir -pv ${APP_CONFIG_DIR}/nginx-proxy-manager
sudo mkdir -pv ${APP_CONFIG_DIR}/letsencrypt
sudo mkdir -pv ${APP_CONFIG_DIR}/mariadb

## Set permissions

compose_file_path=src/tools/nginx-proxy-manager/docker-compose.yml

# Pull latest docker images for all the required services.
docker compose -f $compose_file_path --env-file .env pull

# Run Docker Compose to get all the required services up and running.
docker compose --compatibility -f $compose_file_path --env-file .env up -d
