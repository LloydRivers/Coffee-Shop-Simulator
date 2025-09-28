const { Pool } = require("pg");

const pool = new Pool({
  user: "postgres",
  host: "postgres",
  database: "devdb",
  password: "postgres",
  port: 5432,
});

async function connectPostGres() {
  try {
    const client = await pool.connect();
    console.log("Postgres connected");
    client.release();
  } catch (err) {
    console.error("DB connection error", err);
    throw err;
  }
}

module.exports = { pool, connectPostGres };
