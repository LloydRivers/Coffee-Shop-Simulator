const express = require("express");
const { connectRedis } = require("./config/redisClient");
const { connectPostGres } = require("./config/postgresClient");
const logger = require("./config/logger");
const cors = require("cors");

const app = express();
const port = 3333;

app.use(express.json());
app.use(cors());

(async () => {
  try {
    logger.info("Connecting to Postgres...");
    await connectPostGres();
    logger.info("Postgres connected successfully");

    logger.info("Connecting to Redis...");
    await connectRedis();
    logger.info("Redis connected successfully");

    app.listen(port, () => {
      logger.info(`Example app listening on port ${port}`);
    });
  } catch (err) {
    logger.error("Startup failed", err);
    process.exit(1);
  }
})();
