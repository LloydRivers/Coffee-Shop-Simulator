const { Router } = require("express");
const productRoutes = require("./products.js");
const orderRoutes = require("./orders.js");

const router = Router();

router.use("/products", productRoutes);
router.use("/orders", orderRoutes);

module.exports = router;
