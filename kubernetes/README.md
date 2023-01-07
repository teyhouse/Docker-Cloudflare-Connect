# Docker: Cloudflare Connect
All settings can be found in /config/config.yml -> Convert this to a Kubernetes-Secret later! (Base64)

## Build Docker image for K8S
Build the Docker-Image:   
```bash
docker build -t cloudflare-connect:1.00 .
```
    
Pack the Image:
```bash
docker save --output cloudflare-connect:1.00.tar cloudflare-connect:1.00
```  
  
Import the Image into K3S / K8S:
```bash
sudo k3s ctr images import cloudflare-connect:1.00.tar
```  
  
## Usage

```bash
sudo kubectl apply -f .
```
## cloudflared Version
2022.12.1
  
## License
MIT