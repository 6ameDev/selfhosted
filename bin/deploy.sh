#!/bin/bash

# Load base environment variables
source ./.env

# Pull latest docker images for all the required services.
docker compose pull

# Deploy individual stacks
if [ "$MEDIACENTER" != 'None' ]; then
    ./bin/deploy_mediacenter.sh
fi
if [ "$ENABLE_NEXTCLOUD" = true ]; then
    ./bin/deploy_nextcloud.sh
fi
if [ "$ENABLE_CHANGEDETECTION" = true ]; then
    ./bin/deploy_changed.sh
fi
if [ "$ENABLE_PORTAINER" = true ]; then
    ./bin/deploy_portainer.sh
fi

# Clean up stale docker images
docker image prune -f
