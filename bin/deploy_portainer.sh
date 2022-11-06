#!/bin/bash

echo "App Config Dir: ${APP_CONFIG_DIR}"

# Make users and groups
sudo useradd portainer -u 13200

# Make directories
sudo mkdir -pv ${APP_CONFIG_DIR}/portainer

# Set permissions
sudo chown -R portainer:portainer ${APP_CONFIG_DIR}/portainer

## TODO: Provide the docker-compose file to the docker commands.

# Pull latest docker images for all the required services.
docker compose -f src/tools/portainer/docker-compose.yml pull

# Run Docker Compose to get all the required services up and running.
docker compose --compatibility -f src/tools/portainer/docker-compose.yml up -d

# Clean up stale docker images
docker image prune -f
