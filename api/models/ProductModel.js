import pool from "../config/postgresClient.js";

class ProductModel {
  static async findAll() {
    const result = await pool.query("SELECT * FROM products");
    return result.rows;
  }
}

export default ProductModel;
