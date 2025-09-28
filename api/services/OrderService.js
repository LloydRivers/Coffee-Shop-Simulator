import OrderModel from "../models/OrderModel.js";

class OrderService {
  static async getAllOrders() {
    return await OrderModel.findAll();
  }

  static async createOrder(orderData) {
    return await OrderModel.insert(orderData);
  }
}

export default OrderService;
