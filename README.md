# SelfHosted
[![Deploy](https://github.com/6ameDev/selfhosted/actions/workflows/deploy.yml/badge.svg)](https://github.com/6ameDev/selfhosted/actions/workflows/deploy.yml)

This is a home server setup and primarily uses docker to containerize most of the applications. The application data is encrypted and backed up to a cloud storage.

Some of the use-cases covered in this project are:
- A full blown media server setup (Plex and/or Jellyfin, Servarr apps and a torrent client).
- Changedetection.io for monitoring changes on websites. This comes along with a notification client Apprise.
- NextCloud to host your own cloud storage.
- Portainer for UI based monitoring and maintenance of the docker containers.

Important Links:
- [Setup](docs/setup.md)
- [Maintenance](docs/maintenance.md)
- [Cloudflare Tunnel Setup](docs/cloudflare.md)
