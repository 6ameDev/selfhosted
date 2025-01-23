#!/bin/bash

# Define variables
TIMESTAMP=$(date +%Y%m%d%H%M%S)
BACKUP_DIR="/etc/keepalived/backups"
CONFIG_FILE="/etc/keepalived/keepalived.conf"
REMOTE_MASTER_CONFIG="https://raw.githubusercontent.com/6ameDev/selfhosted/master/src/configs/keepalived.master.conf"
REMOTE_BACKUP_CONFIG="https://raw.githubusercontent.com/6ameDev/selfhosted/master/src/configs/keepalived.backup.conf"

# Default mode is 'master'
MODE="master"

# Function to display usage
usage() {
    echo "Usage: $0 --mode [master|backup]"
    exit 1
}

# Parse command-line arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --mode)
            if [[ "$2" == "master" || "$2" == "backup" ]]; then
                MODE="$2"
                shift
            else
                echo "Error: Invalid mode. Choose 'master' or 'backup'."
                usage
            fi
            ;;
        *)
            echo "Unknown option: $1"
            usage
            ;;
    esac
    shift
done

install_keepalived() {
    echo "Checking if Keepalived is installed..."

    if ! command -v keepalived &> /dev/null; then
        echo "Keepalived not found. Installing..."
        sudo apt update
        sudo apt install -y keepalived
    else
        echo "Keepalived is already installed."
    fi
}

update_keepalived_config() {
    echo "Checking if Keepalived config needs to be updated..."

    # Create backup directory if it doesn't exist
    sudo mkdir -p "$BACKUP_DIR"

    # Choose the correct config file URL based on the mode
    if [ "$MODE" == "master" ]; then
        CONFIG_URL="$REMOTE_MASTER_CONFIG"
    else
        CONFIG_URL="$REMOTE_BACKUP_CONFIG"
    fi

    # Download the config file from GitHub
    TEMP_CONFIG=$(mktemp)
    curl -s "$CONFIG_URL" -o "$TEMP_CONFIG"

    # Check if the current config is different from the downloaded one
    if ! cmp -s "$CONFIG_FILE" "$TEMP_CONFIG"; then
        echo "Config file has changed. Backing up and updating..."

        # Backup the old configuration
        sudo cp "$CONFIG_FILE" "$BACKUP_DIR/keepalived.conf.backup.$TIMESTAMP"

        # Replace the old config with the new one
        sudo cp "$TEMP_CONFIG" "$CONFIG_FILE"
        
        # Clean up the temporary file
        rm "$TEMP_CONFIG"

        echo "Restarting Keepalived service..."
        sudo systemctl restart keepalived
        echo "Keepalived service restarted successfully."
    else
        echo "No changes detected in the config file. No action taken."
        rm "$TEMP_CONFIG"
    fi
}

setup_keepalived() {
    install_keepalived
    update_keepalived_config
}

setup_keepalived
