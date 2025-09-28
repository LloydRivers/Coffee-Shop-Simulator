// services/OrderService.js
const OrderModel = require("../models/OrderModel");

class OrderService {
  static async getAllOrders() {
    return await OrderModel.findAll();
  }

  static async createOrder(orderData) {
    return await OrderModel.insert(orderData);
  }
}

module.exports = OrderService;
