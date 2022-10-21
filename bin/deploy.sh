#!/bin/bash

# Load environment variables
source ./.env
export $(xargs <.env)

# Compile options for the required services
options=""
if [ "$ENABLE_SONARR" = true ]; then
    options="${options} -f ./src/sonarr/docker-compose.yml"
fi
if [ "$ENABLE_RADARR" = true ]; then
    options="${options} -f ./src/radarr/docker-compose.yml"
fi
if [ "$ENABLE_LIDARR" = true ]; then
    options="${options} -f ./src/lidarr/docker-compose.yml"
fi
if [ "$ENABLE_READARR" = true ]; then
    options="${options} -f ./src/readarr/docker-compose.yml"
fi
if [ "$ENABLE_PROWLARR" = true ]; then
    options="${options} -f ./src/prowlarr/docker-compose.yml"
fi
if [ "$ENABLE_QBITTORRENT" = true ]; then
    options="${options} -f ./src/qbittorrent/docker-compose.yml"
fi
if [ "$ENABLE_JELLYFIN" = true ]; then
    options="${options} -f ./src/jellyfin/docker-compose.yml"
fi
if [ "$ENABLE_PLEX" = true ]; then
    options="${options} -f ./src/plex/docker-compose.yml"
fi
if [ "$ENABLE_PORTAINER" = true ]; then
    options="${options} -f ./src/portainer/docker-compose.yml"
fi

# Pull latest docker images for all the required services.
docker compose $options pull

# Run Docker Compose to get all the required services up and running.
docker compose --compatibility $options up -d

# Clean up stale docker images
docker image prune -f
