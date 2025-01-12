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
	@echo "  make deploy STACK=<stackname>  - Deploy a specific stack"

# Create deploy.env file
create-env:
	@echo "Creating deploy.env file..."
	@cp $(ENV_FILE) $(DEPLOYMENT_ENV_FILE)
	@echo "HOST_IP=$(HOST_IP)" >> $(DEPLOYMENT_ENV_FILE)
	@echo "UID=$(UID)" >> $(DEPLOYMENT_ENV_FILE)

# Clean up
clean:
	@echo "Removing deploy.env file..."
	@rm -f $(DEPLOYMENT_ENV_FILE)

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
	@echo "Deploying $(STACK) stack..."
	@trap 'make clean' EXIT; \
	docker compose -f $(APPS_DIR)/$(STACK)-compose.yaml --env-file $(DEPLOYMENT_ENV_FILE) up -d
