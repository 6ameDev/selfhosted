## Cloudflare Tunnel Setup Guide
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
```
