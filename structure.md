## Project Structure

```
coffee-shop-observability/
├── docker-compose.yml          # All services defined here
├── api/                        # Express app lives here
│   ├── package.json
│   ├── server.js              # Main entry point
│   ├── routes/                # API endpoints
│   ├── models/                # Database models/business logic
│   ├── services/              # Background simulator, DB service
│   └── config/                # Database, Redis connections
├── database/                   # Database setup
│   ├── migrations/            # Table creation scripts
│   └── seeds/                 # Sample data generation
├── monitoring/                 # Observability configs
│   ├── prometheus/
│   ├── grafana/
│   └── alertmanager/
└── scripts/                   # Helper scripts
    └── setup.sh               # One command to rule them all
```

## Architecture Style (No Frontend)

Since no frontend, I'd go **service-oriented** rather than strict MVC:

- **Routes**: API endpoints (`/api/orders`, `/api/products`, `/metrics`)
- **Services**: Business logic (OrderService, InventoryService, SimulatorService)
- **Models**: Database interaction (ProductModel, OrderModel)
- **Config**: Database connections, monitoring setup
