# Docker: Cloudflare Connect
A Docker image designed to expose your local docker-services towards Cloudflare Connect (former Cloudflare Argo).  
This will allow exposure of local ressources through Cloudflare without using your certificates. For example in Zero-Trust environments or mass-deployment.   
  
All settings regarding the Ingress-Controller can be found in /config/config.yml.
  
## Prerequisites
 - registered domain on cloudflare (free)
 - config.yml
 - .json-Tunnel Credentials
  
You need to generate your cloudflared-tunnel outside of this docker-container first, before you can use this. 
  
## Create Cloudflare Tunnel
**!RUN THIS OUTSIDE THE DOCKER-CONTAINER!**
   
Download and Install Cloudflared (dpkg -i cloudflared-linux-amd64.deb):  
https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/install-and-setup/installation 
   
Login to Cloudflare:
```bash
cloudflared login
```
Create Tunnel:
```bash
cloudflared tunnel create docker
cloudflared tunnel route dns docker tunnel.fulda-cloud.com
```
  
This will create your Tunnel-Credentials in ~/.cloudflared/.   
Copy **only** the json-file into the config-folder, do not touch the cert (.pem)!  
  
## Build Docker image
Use the predefined VS-Code Task or run:   
```bash
docker build -t cloudflare-connect:1.00 .
```
  
## Usage
  
```bash
docker-compose up -d
```
## cloudflared Version
2024.3.0
  
## License
MIT
