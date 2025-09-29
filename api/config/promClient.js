/*
Credit to the author: Austin Cunningham

I read his article and leaned on his GitHub repo for this code:
https://auscunningham.medium.com/get-prometheus-metrics-from-a-express-js-app-1db690cc1a1
https://github.com/austincunningham/express-prometheus/tree/master

---
This middleware uses `express-prom-bundle` to automatically expose Prometheus
metrics from an Express.js application. It's a "one and done" style solution:
you add it once with `app.use(metricsMiddleware)` and every route in your app
will automatically be instrumented.

Prometheus works by pulling metrics from a `/metrics` endpoint in plain text.
This middleware sets that up for us and also adds some useful defaults:
- Counts of requests, grouped by method, path, and status code.
- Latency histograms, so you can see how long routes take.
- "Up" metric (1 = app is alive).
- Default Node.js process metrics like CPU usage, memory, and event loop lag.
*/
const promBundle = require("express-prom-bundle");
const { Histogram } = require("prom-client");

// Configure the Prometheus middleware
const metricsMiddleware = promBundle({
  // Attach method (GET/POST/etc.) as a label to metrics
  includeMethod: true,

  // Attach the Express path (/orders, /products, etc.) as a label
  includePath: true,

  // Attach HTTP status codes (200, 404, 500, etc.) as a label
  includeStatusCode: true,

  // Include a built-in "up" metric so Prometheus can tell if the app is alive
  includeUp: true,

  // Custom project-wide labels: these will be attached to every metric
  // Helpful when scraping multiple services, so you can filter in Grafana later
  customLabels: {
    project_name: "coffee_shop_simulator",
    project_type: "observability_training",
  },

  // Use histograms instead of counters for HTTP request durations
  // This lets us track latency distributions (p50, p90, p99, etc.)
  metricsType: Histogram,

  // Enable collection of default Node.js metrics (CPU, memory, GC, etc.)
  promClient: {
    collectDefaultMetrics: {},
  },
});

// Export this so it can be mounted once in server.js / app.js
// Example usage:
//   const metricsMiddleware = require("./config/promClient");
//   app.use(metricsMiddleware);
module.exports = metricsMiddleware;
