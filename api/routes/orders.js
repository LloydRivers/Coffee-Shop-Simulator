const express = require("express");
const OrderService = require("../services/OrderService.js");

const router = express.Router();

router.get("/", async (req, res) => {
  try {
    const orders = await OrderService.getAllOrders();
    res.json(orders);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

router.post("/", async (req, res) => {
  try {
    const order = await OrderService.createOrder(req.body);
    res.status(201).json(order);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;
