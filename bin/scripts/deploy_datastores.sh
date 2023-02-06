#!/bin/bash

# Load base environment variables
source ./.env

if [ "$ENABLE_POSTGRES" = true ]; then
    ./bin/scripts/deploy_postgres.sh
fi
