#!/bin/bash

# Load base environment variables
source ./.env

## Deploying ChangeDetection & Chrome
compose_file_path=src/changed/docker-compose.yml

# Pull latest docker images for all the required services.
docker compose -f $compose_file_path pull

# Run Docker Compose to get all the required services up and running.
docker compose --compatibility -f $compose_file_path up -d

## Deploying Apprise
compose_file_path=src/tools/notification/docker-compose.yml

# Pull latest docker images for all the required services.
docker compose -f $compose_file_path --env-file .env pull

# Run Docker Compose to get all the required services up and running.
docker compose --compatibility -f $compose_file_path --env-file .env up -d
