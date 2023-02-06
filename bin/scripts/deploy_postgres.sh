#!/bin/bash

# Load base environment variables
source ./.env

# Copy over the db_init.sh script
cp src/datastores/postgres/db_init.sh ${APP_CONFIG_DIR}/postgres/init/db_init.sh

compose_file_path=src/datastores/postgres/docker-compose.yml

# Pull latest docker images for all the required services.
docker compose -f $compose_file_path pull

# Run Docker Compose to get all the required services up and running.
docker compose --compatibility -f $compose_file_path up -d
