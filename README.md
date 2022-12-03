# SelfHosted
[![Deploy](https://github.com/6ameDev/selfhosted/actions/workflows/deploy.yml/badge.svg)](https://github.com/6ameDev/selfhosted/actions/workflows/deploy.yml)

This is a home server setup and primarily uses docker to containerize most of the applications. The application data is encrypted and backed up to a cloud storage.

Some of the use-cases covered in this project are:
- A full blown media server setup (Plex and/or Jellyfin, Servarr apps and a torrent client).
- Changedetection.io for monitoring changes on websites. This comes along with a notification client Apprise.
- NextCloud to host your own cloud storage.
- Portainer for UI based monitoring and maintenance of the docker containers.

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

### Updating service(s)
1. Running this command will fetch the latest images and deploy the configured services `./bin/deploy.sh`

## Cloudflare Tunnel Guide
```
# Config directory which will be attached as volume to cloudflared container
cloudflared_dir=/path/to/cloudflared/configs

# Login by visiting the generated link and authorize
docker run -it --rm -v $cloudflared_dir:/home/nonroot/.cloudflared/ cloudflare/cloudflared:latest tunnel login

# Create a Cloudflare Tunnel
docker run -it --rm -v $cloudflared_dir:/home/nonroot/.cloudflared/ cloudflare/cloudflared:latest tunnel create <tunnel-name>

# Create DNS for the tunnel
docker run -it --rm -v $cloudflared_dir:/home/nonroot/.cloudflared/ cloudflare/cloudflared:latest tunnel route dns <tunnel-name-or-tunnel-uuid> <dns-name-like-blog.example.com>

docker run -it --rm -v $cloudflared_dir:/home/nonroot/.cloudflared/ cloudflare/cloudflared:latest tunnel run <tunnel-name-or-tunnel-uuid>
OR
Simply just go ahead and deploy cloudflared docker container
