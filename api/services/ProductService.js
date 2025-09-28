// services/ProductService.js
const ProductModel = require("../models/ProductModel");

class ProductService {
  static async getAllProducts() {
    return await ProductModel.findAll();
  }
}

module.exports = ProductService;
