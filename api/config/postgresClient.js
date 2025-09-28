const { Client } = require("pg");

const client = new Client({
  user: "postgres",
  host: "postgres",
  database: "devdb",
  password: "postgres",
  port: 5432,
});

async function connectPostGres() {
  try {
    await client.connect();
    console.log("Postgres connected");
  } catch (err) {
    console.error("DB connection error", err);
    throw err;
  }
}

module.exports = { client, connectPostGres };
