#!/bin/bash

# Load base environment variables
source ./.env

./bin/scripts/deploy_jacksparrow.sh

if [ "$MEDIACENTER" = 'Jellyfin' ] || [ "$MEDIACENTER" = 'Both' ]; then
    ./bin/scripts/deploy_jellyfin.sh
fi

if [ "$MEDIACENTER" = 'Plex' ] || [ "$MEDIACENTER" = 'Both' ]; then
    ./bin/scripts/deploy_plex.sh
fi
