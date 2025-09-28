
-- Products table
CREATE TABLE IF NOT EXISTS products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    category VARCHAR(50) NOT NULL,
    ingredients JSONB NOT NULL,
    prep_time_seconds INTEGER NOT NULL,
    cost_to_make DECIMAL(10,2) NOT NULL,
    profit_margin DECIMAL(5,2) NOT NULL,
    allergens JSONB,
    calories INTEGER,
    seasonal BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Inventory table
CREATE TABLE IF NOT EXISTS inventory (
    ingredient_id VARCHAR(100) PRIMARY KEY,
    current_stock INTEGER NOT NULL,
    reorder_level INTEGER NOT NULL,
    supplier VARCHAR(100),
    cost_per_unit DECIMAL(10,4) NOT NULL,
    expiry_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Orders table
CREATE TABLE IF NOT EXISTS orders (
    id SERIAL PRIMARY KEY,
    order_id VARCHAR(50) UNIQUE NOT NULL,
    customer_id VARCHAR(50),
    items JSONB NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    order_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    prep_start_time TIMESTAMP,
    ready_time TIMESTAMP,
    payment_method VARCHAR(20),
    loyalty_points_used INTEGER DEFAULT 0,
    weather_condition VARCHAR(20),
    status VARCHAR(20) DEFAULT 'pending'
);

-- Insert some starter products
INSERT INTO products (name, price, category, ingredients, prep_time_seconds, cost_to_make, profit_margin, allergens, calories, seasonal) VALUES 
('Espresso', 2.50, 'espresso', '["espresso_beans", "water"]', 30, 0.75, 70.00, '[]', 5, false),
('Americano', 3.00, 'espresso', '["espresso_beans", "water"]', 45, 0.80, 73.33, '[]', 10, false),
('Latte', 4.50, 'espresso_drink', '["espresso_beans", "steamed_milk"]', 90, 1.20, 73.33, '["dairy"]', 190, false),
('Cappuccino', 4.00, 'espresso_drink', '["espresso_beans", "steamed_milk", "milk_foam"]', 75, 1.10, 72.50, '["dairy"]', 120, false),
('Caramel Macchiato', 4.75, 'espresso_drink', '["espresso_beans", "steamed_milk", "caramel_syrup", "vanilla_syrup"]', 120, 1.20, 74.74, '["dairy"]', 250, false)
ON CONFLICT (id) DO NOTHING;

-- Insert starter inventory
INSERT INTO inventory (ingredient_id, current_stock, reorder_level, supplier, cost_per_unit, expiry_date) VALUES
('espresso_beans', 5000, 500, 'Blue Mountain Coffee Co', 0.08, '2025-12-31'),
('steamed_milk', 2000, 200, 'Local Dairy Farm', 0.12, '2025-10-05'),
('caramel_syrup', 800, 100, 'Flavor Corp', 0.15, '2026-06-30'),
('vanilla_syrup', 600, 80, 'Flavor Corp', 0.18, '2026-05-15'),
('milk_foam', 500, 50, 'Local Dairy Farm', 0.20, '2025-10-05')
ON CONFLICT (ingredient_id) DO NOTHING;