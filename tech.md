# Complete Observability Tooling Stack - Coffee Shop Simulator

## Core Application Stack

### Backend Framework

- **Express.js** - Web framework for Node.js
- **Node.js** - JavaScript runtime

### Core Dependencies

```bash
npm install express cors helmet morgan uuid
```

## Observability Trinity: Metrics, Logs, Traces

### 1. METRICS Stack

#### **Prometheus** - Metrics Collection & Storage

- **What it does**: Scrapes and stores time-series metrics data
- **Port**: 9090
- **Config file**: `prometheus.yml`
- **Use case**: Coffee machine temperature, order rates, inventory levels

#### **Node.js Prometheus Client**

```bash
npm install prom-client
```

- **What it does**: Exposes metrics from your Express app
- **Endpoint**: `/metrics` (Prometheus scrapes this)

#### **Grafana** - Visualization & Dashboards

- **What it does**: Creates beautiful dashboards from Prometheus data
- **Port**: 3000
- **Default login**: admin/admin
- **Use case**: Real-time coffee shop dashboards

### 2. LOGGING Stack (ELK)

#### **Elasticsearch** - Search & Analytics Engine

- **What it does**: Stores and indexes log data
- **Port**: 9200
- **Use case**: Searchable coffee shop logs

#### **Logstash** - Log Processing Pipeline

- **What it does**: Collects, processes, and forwards logs
- **Port**: 5044 (beats input), 9600 (API)
- **Use case**: Parse coffee shop log formats

#### **Kibana** - Log Visualization

- **What it does**: Web UI for exploring Elasticsearch data
- **Port**: 5601
- **Use case**: Search coffee shop logs, create log dashboards

#### **Winston** - Node.js Logging Library

```bash
npm install winston winston-elasticsearch
```

- **What it does**: Structured logging in your Express app
- **Formats**: JSON logs that ELK can parse

### 3. DISTRIBUTED TRACING Stack

#### **Jaeger** - Distributed Tracing

- **What it does**: Tracks requests across services
- **Ports**: 16686 (UI), 14268 (HTTP), 6831 (UDP)
- **Use case**: Follow a coffee order from start to finish

#### **OpenTelemetry** - Tracing Instrumentation

```bash
npm install @opentelemetry/api @opentelemetry/sdk-node @opentelemetry/instrumentation-express @opentelemetry/exporter-jaeger
```

- **What it does**: Automatically instruments Express routes
- **Use case**: See which coffee-making step takes longest

### 4. ALERTING Stack

#### **AlertManager** - Alert Routing & Management

- **What it does**: Receives alerts from Prometheus, routes to notifications
- **Port**: 9093
- **Use case**: Alert when coffee machine overheats

#### **Webhook Receiver** (Optional)

- Simple Express endpoint to receive alerts
- Could integrate with Slack, email, SMS

## Development Tools

### **Docker Compose** - Container Orchestration

```yaml
# Services we'll define:
# - coffee-shop-app (our Express app)
# - prometheus
# - grafana
```

### **Health Checks & Testing**

```bash
npm install supertest jest
```

## File Structure

```
coffee-shop-observability/
├── docker-compose.yml
├── app/
│   ├── package.json
│   ├── server.js
│   ├── routes/
│   ├── models/
│   └── config/
├── prometheus/
│   └── prometheus.yml

```

## What Each Tool Teaches You

### **Prometheus + Grafana**

- Time-series data concepts
- Metric types (Counter, Gauge, Histogram, Summary)
- PromQL query language
- Dashboard design
- SLA/SLO monitoring


### Metrics to Monitor

- Orders per minute
- Coffee machine temperature
- Bean inventory levels
- Order success/failure rate
- Average order processing time
- Customer queue length


### Traces to Follow

- Customer order → Inventory check → Machine assignment → Coffee brewing → Order completion
- Failed order troubleshooting
- Performance optimization

### Alerts to Configure

- Machine temperature > 95°C
- Bean inventory < 10%
- Order failure rate > 5%
- Queue length > 10 customers
- Average processing time > 5 minutes

## Getting Started Command

```bash
# Clone structure
mkdir coffee-shop-observability
cd coffee-shop-observability

# Initialize Node.js app
mkdir app
cd app
npm init -y
npm install express prom-client winston winston-elasticsearch @opentelemetry/api @opentelemetry/sdk-node @opentelemetry/instrumentation-express @opentelemetry/exporter-jaeger

# Back to root for Docker setup
cd ..
# Create docker-compose.yml and config files
```
