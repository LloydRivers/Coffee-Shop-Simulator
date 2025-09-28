// models/ProductModel.js
const { pool } = require("../config/postgresClient");

class ProductModel {
  static async findAll() {
    const result = await pool.query("SELECT * FROM products");
    return result.rows;
  }
}

module.exports = ProductModel;
