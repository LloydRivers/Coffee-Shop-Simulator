import pool from "../config/postgresClient.js";

class OrderModel {
  static async findAll() {
    const result = await pool.query("SELECT * FROM orders");
    return result.rows;
  }

  static async insert(orderData) {
    const {
      order_id,
      customer_id,
      items,
      total_price,
      payment_method,
      status,
    } = orderData;
    const result = await pool.query(
      `INSERT INTO orders (order_id, customer_id, items, total_price, payment_method, status)
       VALUES ($1, $2, $3, $4, $5, $6)
       RETURNING *`,
      [
        order_id,
        customer_id,
        JSON.stringify(items),
        total_price,
        payment_method,
        status,
      ]
    );
    return result.rows[0];
  }
}

export default OrderModel;
