const { Router } = require("express");
const ProductService = require("../services/ProductService.js");

const router = Router();

router.get("/", async (req, res) => {
  try {
    const products = await ProductService.getAllProducts();
    res.json(products);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;
