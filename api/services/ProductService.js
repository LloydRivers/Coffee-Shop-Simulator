import ProductModel from "../models/ProductModel.js";

class ProductService {
  static async getAllProducts() {
    return await ProductModel.findAll();
  }
}

export default ProductService;
