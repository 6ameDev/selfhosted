#!/bin/bash

# Load base environment variables
source ./.env

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
if [ "$ENABLE_NGINX_PROXY_MANAGER" = true ]; then
    ./bin/deploy_nginx_proxy_manager.sh
fi
if [ "$ENABLE_TUNNEL" = true ]; then
    ./bin/deploy_tunnel.sh
fi
if [ "$ENABLE_PORTAINER" = true ]; then
    ./bin/deploy_portainer.sh
fi

# Clean up stale docker images
docker image prune -f
