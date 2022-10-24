# ChillArr
ChillArr is a project aimed at making it blazing fast to setup a Servarr application suite based mediacenter running on Docker.

Featured applications:
- [Sonarr](https://sonarr.tv/) is a PVR for Usenet and BitTorrent users. It can monitor multiple RSS feeds for new episodes of your favorite shows and will grab, sort and rename them. It can also be configured to automatically upgrade the quality of files already downloaded when a better quality format becomes available.
- [Radarr](https://radarr.video/) is a movie collection manager for Usenet and BitTorrent users. It can monitor multiple RSS feeds for new movies and will interface with clients and indexers to grab, sort, and rename them. It can also be configured to automatically upgrade the quality of existing files in the library when a better quality format becomes available.
- [Lidarr](https://lidarr.audio/) is a music collection manager for Usenet and BitTorrent users. It can monitor multiple RSS feeds for new tracks from your favorite artists and will grab, sort and rename them. It can also be configured to automatically upgrade the quality of files already downloaded when a better quality format becomes available.
- [Readarr](https://readarr.com/) is an eBook and audiobook collection manager for Usenet and BitTorrent users. It can monitor multiple RSS feeds for new books and will interface with clients and indexers to grab, sort, and rename them. It can also be configured to automatically upgrade the quality of existing files in the library when a better quality format becomes available. It does not manage comics or magazines.
- [Prowlarr](https://wiki.servarr.com/prowlarr) is an indexer manager/proxy built on the popular arr .net/reactjs base stack to integrate with your various PVR apps. Prowlarr supports management of both Torrent Trackers and Usenet Indexers. It integrates seamlessly with Lidarr, Mylar3, Radarr, Readarr, and Sonarr offering complete management of your indexers with no per app Indexer setup required
- [qBittorrent](https://www.qbittorrent.org/) The qBittorrent project aims to provide an open-source software alternative to µTorrent. Additionally, qBittorrent runs and provides the same features on all major platforms (FreeBSD, Linux, macOS, OS/2, Windows).
- [Jellyfin](https://jellyfin.org/) is the volunteer-built media solution that puts you in control of your media. Stream to any device from your own server, with no strings attached. Your media, your server, your way.

## Setup

### Pre-requisites
1. `docker` should be installed.
2. `docker-compose` should be installed.

Note: Ensure you have added your user to docker group. To do so you can run `sudo usermod -aG docker ${USER}`

### Steps
1. Clone the repository to your preferred directory and `cd` into it.
2. Create a `.env` file by running `$ cp .env.sample .env`.
3. Set the variables in `.env` file as per your preferences.
5. Run the command `$ ./bin/init.sh` as a superuser. This is a one-time setup, required to create the necessary directories, service users and grant them only the needed permissions.
6. Run the command `$ ./bin/deploy.sh` as a superuser.

### Updating service(s)
1. Run the command `$ ./bin/deploy.sh` as a superuser.
