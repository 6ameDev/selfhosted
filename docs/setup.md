## Setup

### Pre-requisites
1. `docker` should be installed.
2. `docker compose` should be installed.

Note: Ensure you have added your user to docker group. To do so you can run `sudo usermod -aG docker ${USER}`

### Steps
1. Clone the repository on your local machine.
2. `cd` into the `selfhosted` directory.
3. Run the command `cp .env.sample .env`.
4. Edit the `.env` file using `sudo nano .env`
5. Modify the configurations as applicable to you. To save and exit press `ctrl+x`, followed by `y`, followed by pressing `enter`.
6. Run the command to deploy the configured services `./bin/deploy.sh`
