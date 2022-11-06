#!/bin/bash

## Make directories
sudo mkdir -pv ${APP_CONFIG_DIR}/nextcloud/{main,apps,config,theme}
sudo mkdir -pv ${APP_CONFIG_DIR}/postgres

## Set permissions
# www-data user must own the nextcloud directories
sudo chown -R www-data:$(id -u) ${APP_CONFIG_DIR}/nextcloud
sudo chown -R www-data:$(id -u) ${DATA_DIR}

# 999 is the postgres user
sudo chown -R 999:$(id -u) ${APP_CONFIG_DIR}/postgres

compose_file_path=src/nextcloud/docker-compose.yml

# Pull latest docker images for all the required services.
docker compose -f $compose_file_path pull

# Run Docker Compose to get all the required services up and running.
docker compose --compatibility -f $compose_file_path up -d
