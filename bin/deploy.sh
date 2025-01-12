#!/bin/bash

# Load base environment variables
source ./.env

if [ "$ENABLE_GHOSTFOLIO" = true ]; then
    ./bin/scripts/deploy_ghostfolio.sh
fi
if [ "$ENABLE_NGINX_PROXY_MANAGER" = true ]; then
    ./bin/scripts/deploy_nginx_proxy_manager.sh
fi

# Clean up stale docker images
docker image prune -f
