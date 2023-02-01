## Maintenance & Upgrades

### Basic (system updates and selfhosted apps updates)
```
sudo apt update
sudo apt full-upgrade -y

# change directory to the project selfhosted
./bin/deploy.sh
```

### Pi-Hole
```
pihole updatePihole
pihole updateGravity
```
