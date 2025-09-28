const express = require("express");
const { connectRedis } = require("./config/redisClient");
const { connectPostGres } = require("./config/postgresClient");

const app = express();
const port = 3333;

app.use(express.json());
app.use(cors());

(async () => {
  try {
    console.log("Connecting to Postgres...");
    await connectPostGres();
    console.log("Postgres connected successfully");

    console.log("Connecting to Redis...");
    await connectRedis();
    console.log("Redis connected successfully");

    app.listen(port, () => {
      console.log(`Example app listening on port ${port}`);
    });
  } catch (err) {
    console.error("Startup failed", err);
    process.exit(1);
  }
})();
