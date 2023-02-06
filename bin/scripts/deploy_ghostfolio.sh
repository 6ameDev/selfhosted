#!/bin/bash

# Load base environment variables
source ./.env

compose_file_path=src/ghostfolio/docker-compose.yml

# Pull latest docker images for all the required services.
docker compose -f $compose_file_path pull

# Run Docker Compose to get all the required services up and running.
docker compose --compatibility -f $compose_file_path up -d
