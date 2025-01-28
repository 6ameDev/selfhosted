# PiHole Setup

## Ubuntu Server

## Disable systemd-resolved (Port 53)
```up
sudo systemctl disable systemd-resolved.service
sudo systemctl stop systemd-resolved.service
sudo unlink /etc/resolv.conf
```

```temp
sudo echo "nameserver 1.1.1.1" > /etc/resolv.conf
# Start pihole container
sudo rm -rf /etc/resolv.conf
```

```down
sudo ln -s /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
sudo systemctl enable systemd-resolved.service
sudo systemctl start systemd-resolved.service
```

## Add Wildcard DNS to PiHole
1. In pihole, go to /etc/dnsmasq.d/
2. Create a new file called 02-wildcard-dns.conf
3. Edit the file, and add a line like this: `address=/home.lab/<ip-for-reverse-proxy-machine>`
4. Save the file, and exit the editor
5. Restart the pihole container
```
