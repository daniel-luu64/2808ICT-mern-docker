## What
- Added Nginx HTTPS reverse proxy for Docker Compose and Kubernetes
- Routes:
  - `/` → frontend (port 80)
  - `/api/` → backend (port 3000)
  - `/db/` → mongo-express (port 8081)

## How to Test (Docker)
1. `cd infra/nginx-proxy && ./generate_ssl.sh`
2. `docker compose -f docker-compose.yml -f infra/nginx-proxy/compose.nginx.yml up -d --build`
3. Visit:
   - https://<EC2-IP>/ → frontend
   - https://<EC2-IP>/api/health → backend
   - https://<EC2-IP>/db/ → mongo-express
4. `docker compose logs proxy`

## How to Test (K8s)
1. `kubectl create ns app`
2. `kubectl -n app create secret tls tls-dev --cert=infra/nginx-proxy/certs/localhost.crt --key=infra/nginx-proxy/certs/localhost.key`
3. `kubectl -n app apply -f infra/k8s/proxy-configmap.yml`
4. `kubectl -n app apply -f infra/k8s/proxy-deployment.yml`
5. `kubectl -n app apply -f infra/k8s/proxy-service.yml`
6. `kubectl -n app get pods,svc`
7. Test NodePort: `curl -k https://<node-ip>:30443/`

## Screenshots Checklist
- [ ] Cert generation output (`./generate_ssl.sh`)
- [ ] `docker compose ps`
- [ ] Browser: https://<EC2-IP>/
- [ ] Browser: https://<EC2-IP>/db/
- [ ] `docker compose logs proxy`
- [ ] `kubectl get pods,svc -n app`
- [ ] `curl -k https://<node-ip>:30443/`

## Notes
- No real `.env` committed (only `.env.example`)
- Ports: Frontend 80, Backend 3000, Mongo 27017, Proxy 443
