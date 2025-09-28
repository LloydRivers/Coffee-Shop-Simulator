const redis = require("redis");

const client = redis.createClient({
  url: "redis://redis:6379",
  password: "eYVX7EwVmmxKPCDmwMtyKVge8oLd2t81",
});

client.on("error", (err) => console.error("Redis Client Error", err));

async function connectRedis() {
  try {
    await client.connect();
    console.log("Redis connected");
  } catch (err) {
    console.error("Redis connection error", err);
    throw err;
  }
}

module.exports = { client, connectRedis };
