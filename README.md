# 2808ICT MERN Docker Setup

This project demonstrates how to containerize a MERN application (MongoDB, Express, React, Node.js) for deployment on AWS EC2.  
Each part of the stack (frontend, backend, MongoDB) runs in its own container.

---

## Backend

### Build and run the backend container:
```bash
docker build -t mern-backend ./server

docker run -d --name backend \
  --restart unless-stopped \
  --env-file ./server/.env \
  --add-host=host.docker.internal:host-gateway \
  -p 3000:3000 mern-backend
```

Verify backend is working:
- Visit: `http://<EC2_PUBLIC_IP>:3000/` → shows **App is running**
- Visit: `http://<EC2_PUBLIC_IP>:3000/health` → returns `{ "ok": true }`

---

## Frontend

### Build and run the frontend container:
```bash
docker build -t mern-frontend \
  --build-arg REACT_APP_API_URL="http://<EC2_PUBLIC_IP>:3000" ./client

docker run -d --name frontend -p 80:80 mern-frontend
```

Verify frontend is working:
- Visit: `http://<EC2_PUBLIC_IP>/`
- React app should load and connect to backend API.

---

## 🗄 MongoDB (to be added by teammate)

The backend expects a MongoDB connection string.  
Once MongoDB is containerized or provided via MongoDB Atlas, add the following to the `.env` file:

```ini
MONGO_URI=mongodb://mongo:27017/appdb?authSource=admin
MONGO_DB=appdb
```

---

## Environment Variables

### Backend `.env` example
```ini
NODE_ENV=production
PORT=3000
CORS_ORIGIN=http://<EC2_PUBLIC_IP>
MONGO_URI=   # leave empty until DB is ready
MONGO_DB=appdb
```

### Frontend build-time variable
```bash
--build-arg REACT_APP_API_URL="http://<EC2_PUBLIC_IP>:3000"
```

---

## Development Notes

- `.gitignore` excludes `.env` and `node_modules`
- Each feature should be pushed to its own branch:
  - `feature/frontend-docker`
  - `feature/backend-docker`
  - `feature/mongodb-docker` (pending)

---

## Team Workflow

1. Each teammate works on a **feature branch**.  
2. Push changes to GitHub.  
3. Open a **Pull Request (PR)** for review.  
4. Once approved, merge into **main**.  

---

## Health Check Endpoints

- **Backend Root** → `GET /` → `"App is running"`  
- **Backend Health** → `GET /health` → `{ "ok": true }`  

---
