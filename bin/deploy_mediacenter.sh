#!/bin/bash

# Load base environment variables
source ./.env

./bin/deploy_jacksparrow.sh

if [ "$MEDIACENTER" = 'Jellyfin' ] || [ "$MEDIACENTER" = 'Both' ]; then
    ./bin/deploy_jellyfin.sh
fi

if [ "$MEDIACENTER" = 'Plex' ] || [ "$MEDIACENTER" = 'Both' ]; then
    ./bin/deploy_plex.sh
fi
