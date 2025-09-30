#!/bin/sh
# Load testing script for coffee-shop-app
#
# Usage:
#   REQUESTS=200 ./load.sh           # run 200 iterations
#   DURATION=30 ./load.sh            # run for ~30 seconds
#   ENDPOINT=http://coffee-shop-app:3333/ ./load.sh
#
# Defaults:
#   REQUESTS=100
#   DURATION unset (count mode)
#   ENDPOINT=http://coffee-shop-app:3333/
#   SLEEP_SEC=0.1

# Exit on error
set -e  

ENDPOINT=${ENDPOINT:-http://api:3333/api/products}
REQUESTS=${REQUESTS:-100}
DURATION=${DURATION:-}
SLEEP_SEC=${SLEEP_SEC:-0.1}

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Load Test Starting"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Endpoint:   ${ENDPOINT}"
echo "Requests:   ${REQUESTS}"
echo "Duration:   ${DURATION:-N/A (using count mode)}"
echo "Sleep:      ${SLEEP_SEC}s between iterations"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Verify endpoint is reachable
echo "Testing endpoint connectivity..."
if ! curl -s -f -o /dev/null --max-time 5 "${ENDPOINT}"; then
  echo "❌ ERROR: Cannot reach ${ENDPOINT}"
  echo "   Make sure coffee-shop-app is running"
  exit 1
fi
echo "✓ Endpoint is reachable"
echo ""

# Run load test
if [ -n "$DURATION" ]; then
  # Time-based mode
  echo "Running time-based load test (${DURATION} seconds)..."
  END_TIME=$(( $(date +%s) + DURATION ))
  i=0
  
  while [ $(date +%s) -lt $END_TIME ]; do
    i=$((i+1))
    
    # Make requests to different endpoints
    curl -s -o /dev/null "${ENDPOINT}" || true
    curl -s -o /dev/null "${ENDPOINT}hello" || true
    curl -s -o /dev/null -X POST \
      -H "Content-Type: application/json" \
      -d '{"name":"loadtest","email":"load@test.local"}' \
      "${ENDPOINT}bye" || true
    
    # Progress indicator every 10 iterations
    if [ $((i % 10)) -eq 0 ]; then
      echo "  Completed ${i} iterations..."
    fi
    
    sleep ${SLEEP_SEC}
  done
  
  echo ""
  echo "✓ Finished time-based load test"
  echo "  Duration: ${DURATION}s"
  echo "  Iterations: ${i}"
  echo "  Total requests: ~$((i * 3))"
  
else
  # Count-based mode
  echo "Running count-based load test (${REQUESTS} iterations)..."
  i=0
  
  while [ $i -lt "$REQUESTS" ]; do
    i=$((i+1))
    
    # Make requests to different endpoints
    curl -s -o /dev/null "${ENDPOINT}" || true
    curl -s -o /dev/null "${ENDPOINT}hello" || true
    curl -s -o /dev/null -X POST \
      -H "Content-Type: application/json" \
      -d '{"name":"loadtest","email":"load@test.local"}' \
      "${ENDPOINT}bye" || true
    
    # Progress indicator every 10 iterations
    if [ $((i % 10)) -eq 0 ]; then
      echo "  Completed ${i}/${REQUESTS} iterations..."
    fi
    
    sleep ${SLEEP_SEC}
  done
  
  echo ""
  echo "✓ Finished count-based load test"
  echo "  Iterations: ${REQUESTS}"
  echo "  Total requests: $((REQUESTS * 3))"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Load Test Complete!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Next steps:"
echo "  1. Check metrics: http://localhost:3333/metrics"
echo "  2. View in Prometheus: http://localhost:9090"
echo "  3. View in Grafana: http://localhost:3000"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"