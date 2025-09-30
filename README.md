# ☕ Coffee Shop App – Observability Playground

This project is a small **Express.js + Postgres API** wrapped in Docker, with an **observability stack** (Prometheus + Grafana) to explore how modern monitoring fits into a real service.

It’s not a production system — it’s a learning sandbox to practice:

- Container orchestration with Docker Compose
- Databases and caching (Postgres + Redis)
- Metrics collection and dashboards (Prometheus + Grafana)
- Hands-on debugging + service health checks

---

## 🗂 Project Structure

We run two compose files:

- **`docker-compose.yml`** → the core app stack
- **`docker-compose.observability.yml`** → observability stack

The `api` directory contains all source code and scripts.

---

## 🚀 Core App Stack (`docker-compose.yml`)

### `api` (Express.js)

- Simple Node.js service exposing endpoints on **port 3333**
- Connects to Postgres with `DATABASE_URL`
- Runs in dev mode (hot-reloads with volume mounts)

### `postgres` (Database)

- Official **Postgres** image, exposed on **5432**
- Init script: `db/init.sql` creates schema and tables on startup
- Healthcheck ensures the DB is ready before the API runs

### `pgadmin` (DB Admin UI)

- Web UI for Postgres on **[http://localhost:8080](http://localhost:8080)**
- Default login: `admin@example.com / admin`

### `redis` (Cache)

- Redis 6.2 with a persistent volume
- Password-protected
- Exposed on **6379**

---

## 📈 Observability Stack (`docker-compose.observability.yml`)

### `prometheus`

- Scrapes metrics from the API and itself
- Configured via `prometheus.yml`
- Web UI: **[http://localhost:9090](http://localhost:9090)**

### `grafana`

- Dashboards + visualizations
- Default login: `admin / admin`
- Pre-provisioned with Prometheus as a datasource
- Web UI: **[http://localhost:3000](http://localhost:3000)**

---

## 🛠 Running the Project

1. **Enter the API directory first**

```sh
cd api
```

2. **Start all services (core + observability)**

```sh
npm run up:all
# Equivalent to:
# docker-compose -f ../docker-compose.yml -f ../docker-compose.monitoring.yml up -d
```

3. **Stop all services**

```sh
npm run down:all
# Equivalent to:
# docker-compose -f ../docker-compose.yml -f ../docker-compose.monitoring.yml down
```

---

## ⚡ Load Testing Scripts

You can simulate traffic with the following commands (all use the same script, behavior changes via environment variables):

```sh
# Quick test (100 requests, gentle)
npm run load:quick

# Medium test (200 requests, faster)
npm run load:medium

# Duration test (run for 30 seconds)
npm run load:duration

# Stress test (500 requests, very fast)
npm run load:stress
```

**How it works:** The script reads environment variables to decide:

- `REQUESTS` → how many iterations to run
- `DURATION` → total runtime in seconds (overrides `REQUESTS`)
- `SLEEP_SEC` → pause between requests
- `ENDPOINT` → which API endpoint to target

---

## 🔍 What We Learned

- Wiring up multi-service stacks with **Express, Postgres, Redis**
- Exposing DB data via **pgAdmin**
- Monitoring services with **Prometheus**
- Visualizing metrics in **Grafana dashboards**
- Debugging health checks, container restarts, and networking

---

## 📸 Next Steps / Ideas

- Add **tracing (Jaeger)** for request-level latency
- Add **logs (ELK or Loki)** for richer observability
- Experiment with **Alertmanager** for real-time notifications

---
