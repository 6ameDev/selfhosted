MAKEFLAGS += --no-print-directory

# Variables
HOST_IP := $(shell hostname -I | cut -d ' ' -f1)
UID := $(shell id -u)
ENV_FILE := .env
DEPLOYMENT_ENV_FILE := deploy.env
APPS_DIR := src/apps

# Default target
.PHONY: help
help:
	@echo "Available commands:"
	@echo "  make deploy-tailscale          - Deploy tailscale stack"
	@echo "  make deploy STACK=<stackname>  - Deploy a specific stack"

# Create deploy.env file
create-env:
	@echo "Creating deploy.env file..."
	@cp $(ENV_FILE) $(DEPLOYMENT_ENV_FILE)
	@echo "HOST_IP=$(HOST_IP)" >> $(DEPLOYMENT_ENV_FILE)
	@echo "UID=$(UID)" >> $(DEPLOYMENT_ENV_FILE)

# Clean up
clean:
	@echo "Cleaning up..."
	@rm -f $(DEPLOYMENT_ENV_FILE)
	@docker image prune -f
	@docker system prune -f

# Deploy tailscale stack
.PHONY: deploy-tailscale
deploy-tailscale:
	@make create-env
	@echo "Deploying TailScale..."
	@trap 'make clean' EXIT; \
	docker compose -f src/tailscale/compose.yaml --env-file $(DEPLOYMENT_ENV_FILE) up -d

# Deploy a specific stack
.PHONY: deploy
deploy:
	@if [ -z "$(STACK)" ]; then \
		echo "Error: STACK parameter is required. Usage: make deploy STACK=<stackname>"; \
		exit 1; \
	fi
	@if [ ! -f "$(APPS_DIR)/$(STACK)-compose.yaml" ]; then \
		echo "Error: Compose file $(APPS_DIR)/$(STACK)-compose.yaml does not exist"; \
		exit 1; \
	fi
	@make create-env
	@echo "Pulling & Deploying $(STACK) stack..."
	@trap 'make clean' EXIT; \
	( \
		docker compose -f $(APPS_DIR)/$(STACK)-compose.yaml --env-file $(DEPLOYMENT_ENV_FILE) pull && \
		docker compose -f $(APPS_DIR)/$(STACK)-compose.yaml --env-file $(DEPLOYMENT_ENV_FILE) up -d \
	)
