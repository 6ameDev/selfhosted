MAKEFLAGS += --no-print-directory

# Variables
APPS_DIR := src/apps
ENV_DIR := src/env
BASE_ENV := base.env
DEPLOYMENT_ENV_FILE := deploy.env
# PATH_TO_SEARCH := ./src/apps
FILENAME_PATTERN := *-compose.yaml

# Default target
.PHONY: help
help:
	@echo "Available commands:"
	@echo "  make ls"
	@echo "  make deploy STACK=<stackname>  - Deploy a specific stack"
	@echo ""
	@echo "Available stacks:"
	@find $(APPS_DIR) -type f -name "$(FILENAME_PATTERN)" | \
		awk -F'/' '{print $$NF}' | \
		sed 's/-compose.yaml//g' | \
		sort

# List running stacks
.PHONY: ls
ls:
	@docker ps --format '{{.Label "com.docker.compose.project"}}'

# Create deploy env
create-env:
	@if BASE_ENV_FILE="$(ENV_DIR)/$(BASE_ENV)"; [ ! -f "$$BASE_ENV_FILE" ]; then \
		echo "Base .env file '$$BASE_ENV_FILE' not found!"; \
		exit 1; \
	else \
		if STACK_ENV_FILE="$(ENV_DIR)/$(STACK).env"; [ -f "$$STACK_ENV_FILE" ]; then \
			echo "Using merged .env file. Found: '$$STACK_ENV_FILE'"; \
			cp "$$BASE_ENV_FILE" "$(DEPLOYMENT_ENV_FILE)"; \
			echo "\n# Stack file env variables\n" >> "$(DEPLOYMENT_ENV_FILE)"; \
			cat "$$STACK_ENV_FILE" >> "$(DEPLOYMENT_ENV_FILE)"; \
		else \
			echo "Using base .env file. Not Found: '$$STACK_ENV_FILE'"; \
			cp "$$BASE_ENV_FILE" "$(DEPLOYMENT_ENV_FILE)"; \
		fi \
	fi

# Clean up
clean:
	@echo "Cleaning up..."
	@rm -f $(DEPLOYMENT_ENV_FILE)
	@docker image prune -f
	@docker system prune -f

# Deploy stack
.PHONY: deploy
deploy:
	@if [ -z "$(STACK)" ]; then \
		echo "Error: STACK parameter is required. Usage: make deploy STACK=<stackname>"; \
		exit 1; \
	fi
	@if COMPOSE_FILE="$(APPS_DIR)/$(STACK)-compose.yaml"; [ ! -f "$$COMPOSE_FILE" ]; then \
		echo "Error: Compose file $$COMPOSE_FILE does not exist"; \
		exit 1; \
	else \
		make create-env; \
		echo "Deploying $(STACK)"; \
		trap 'make clean' EXIT; \
		( \
			docker compose -f $$COMPOSE_FILE --env-file $(DEPLOYMENT_ENV_FILE) pull && \
			docker compose -f $$COMPOSE_FILE --env-file $(DEPLOYMENT_ENV_FILE) up -d \
		) \
	fi

# Setup hotflix
.PHONY: setup-hotflix
setup-hotflix:
	@echo "Creating deploy.env file..."
	@cp $(BASE_ENV) $(DEPLOYMENT_ENV_FILE)
	@cat src/env/hotflix.env >> $(DEPLOYMENT_ENV_FILE)
	@trap 'make clean' EXIT; \
	./src/init/hotflix.sh
