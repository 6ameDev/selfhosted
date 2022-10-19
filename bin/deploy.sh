#!/bin/bash

# Load environment variables
source ./.env

# Pull latest docker images for all the required services.
# Remove the lines for the services you do NOT require.

docker-compose \
    -f ./src/sonarr/docker-compose.yml \
    -f ./src/radarr/docker-compose.yml \
    -f ./src/lidarr/docker-compose.yml \
    -f ./src/readarr/docker-compose.yml \
    -f ./src/prowlarr/docker-compose.yml \
    -f ./src/qbittorrent/docker-compose.yml \
    -f ./src/jellyfin/docker-compose.yml \
    pull

# Run Docker Compose to get all the required services up and running.
# Remove the lines for the services you do NOT require.

docker-compose --compatibility \
    -f ./src/sonarr/docker-compose.yml \
    -f ./src/radarr/docker-compose.yml \
    -f ./src/lidarr/docker-compose.yml \
    -f ./src/readarr/docker-compose.yml \
    -f ./src/prowlarr/docker-compose.yml \
    -f ./src/qbittorrent/docker-compose.yml \
    -f ./src/jellyfin/docker-compose.yml \
    up -d

# Clean up stale docker images
docker image prune -f
