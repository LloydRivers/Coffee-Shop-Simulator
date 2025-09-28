Load Generation Options (Easiest to Most Advanced)

1. Built-in Simulator (My top pick for learning)
   Your Express app runs a background process that simulates customers:

Every 10 seconds, generate 1-3 random orders
Varies by time of day (more at 8am, less at 3pm)
Occasionally breaks machines, runs out of ingredients
Pro: Always generating data, no extra tools needed

2. Simple Node.js Script
   Separate script that hits your API endpoints:

Runs alongside your app
Makes HTTP requests to place orders
Easy to control and modify
Pro: Learn HTTP client programming

3. k6 (Industry standard)
   Load testing tool, great for learning real practices

Realistic traffic patterns
Ramp up/down scenarios
Pro: Learn professional load testing

4. Artillery (Simpler than k6)
   Another load testing tool, easier config

YAML configuration
Good for learning basics
