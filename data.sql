USE retail_sales;

START TRANSACTION;

INSERT INTO province (province_name) VALUES
('Barcelona'), ('Madrid'), ('Valencia'),('Seville'), ('Malaga'), ('Granada'), ('Bilbao'),
('Zaragoza'), ('Toledo'), ('Murcia');

INSERT INTO store (store_name, province, opened_date) VALUES
('Store 01', 'Barcelona', '2018-01-01'),
('Store 02', 'Madrid', '2018-02-01'),
('Store 03', 'Valencia', '2018-03-01'),
('Store 04', 'Seville', '2018-04-01'),
('Store 05', 'Malaga', '2018-05-01'),
('Store 06', 'Granada', '2018-06-01'),
('Store 07', 'Bilbao', '2018-07-01'),
('Store 08', 'Zaragoza', '2018-08-01'),
('Store 09', 'Toledo', '2018-09-01'),
('Store 10', 'Salamanca', '2018-10-01'),

('Store 11', 'Cordoba', '2019-01-01'),
('Store 12', 'Cadiz', '2019-02-01'),
('Store 13', 'Almeria', '2019-03-01'),
('Store 14', 'Murcia', '2019-04-01'),
('Store 15', 'Alicante', '2019-05-01'),
('Store 16', 'Castellon', '2019-06-01'),
('Store 17', 'Tarragona', '2019-07-01'),
('Store 18', 'Girona', '2019-08-01'),
('Store 19', 'Lleida', '2019-09-01'),
('Store 20', 'Huesca', '2019-10-01'),

('Store 21', 'Teruel', '2020-01-01'),
('Store 22', 'Soria', '2020-02-01'),
('Store 23', 'Segovia', '2020-03-01'),
('Store 24', 'Avila', '2020-04-01'),
('Store 25', 'Leon', '2020-05-01'),
('Store 26', 'Burgos', '2020-06-01'),
('Store 27', 'Palencia', '2020-07-01'),
('Store 28', 'Zamora', '2020-08-01'),
('Store 29', 'Valladolid', '2020-09-01'),
('Store 30', 'Logrono', '2020-10-01');

INSERT INTO product (product_name, category, unit_price) VALUES
('Milk', 'Dairy', 1.20),
('Bread', 'Bakery', 0.90),
('Apple', 'Fruit', 2.50),
('Cheese','Dairy',2.80),
('Yogurt','Dairy',0.80),
('Butter','Dairy',1.90),
('Croissant','Bakery',1.20),
('Bagel','Bakery',1.10),
('Banana','Fruit',1.80),
('Orange','Fruit',2.00),
('Tomato','Vegetable',1.70),
('Potato','Vegetable',1.30),
('Onion','Vegetable',1.10),
('Chicken','Meat',5.20),
('Beef','Meat',7.80),
('Fish','Seafood',6.50),
('Rice','Grains',1.40),
('Pasta','Grains',1.30),
('Oil','Grocery',4.20),
('Sugar','Grocery',1.10),
('Salt','Grocery',0.60),
('Coffee','Beverage',3.90),
('Tea','Beverage',2.80),
('Juice','Beverage',2.20),
('Water','Beverage',0.70),
('Chocolate','Snack',1.60),
('Biscuits','Snack',1.40),
('Chips','Snack',1.50);

INSERT INTO customer (customer_name, gender, age) VALUES
('Carlos Ruiz','M',26),
('Ana Lopez','F',15),
('Maria Gomez','F',51),
('Javier Morales','M',70),
('Laura Martinez','F',56),
('Miguel Santos','M',59),
('Sofia Hernandez','F',55),
('Alejandro Gomez','M',19),
('Lucia Ramos','F',19),
('Luis Fernandez','M',20),
('Paula Diaz','F',35),
('Sergio Alvarez','M',39),
('Elena Cruz','F',42),
('Diego Navarro','M',60),
('Natalia Fuentes','F',77),
('Antonio Torres','M',49),
('Patricia Leon','F',29),
('Marcos Jimenez','M',30),
('Claudia Pardo','F',33),
('Rafael Molina','M',18),
('Beatriz Soto','F',16),
('Victor Herrera','M',25),
('Monica Rios','F',55),
('Andres Castillo','M',77),
('Andrea Blanco','F',37),
('Ivan Ortega','M',28),
('Isabel Moreno','F',30);



INSERT INTO calendar (date_id, day, month, year) VALUES
('2025-01-01', 1, 1, 2025),
('2025-01-02', 2, 1, 2025),
('2025-01-03', 3, 1, 2025),
('2025-01-04', 4, 1, 2025),
('2025-01-05', 5, 1, 2025),
('2025-01-06', 6, 1, 2025),
('2025-01-07', 7, 1, 2025),
('2025-01-08', 8, 1, 2025),
('2025-01-09', 9, 1, 2025),
('2025-01-10', 10, 1, 2025),
('2025-01-11', 11, 1, 2025),
('2025-01-12', 12, 1, 2025),
('2025-01-13', 13, 1, 2025),
('2025-01-14', 14, 1, 2025),
('2025-01-15', 15, 1, 2025),
('2025-01-16', 16, 1, 2025),
('2025-01-17', 17, 1, 2025),
('2025-01-18', 18, 1, 2025),
('2025-01-19', 19, 1, 2025),
('2025-01-20', 20, 1, 2025),
('2025-01-21', 21, 1, 2025),
('2025-01-22', 22, 1, 2025),
('2025-01-23', 23, 1, 2025),
('2025-01-24', 24, 1, 2025),
('2025-01-25', 25, 1, 2025),
('2025-01-26', 26, 1, 2025),
('2025-01-27', 27, 1, 2025),
('2025-01-28', 28, 1, 2025),
('2025-01-29', 29, 1, 2025),
('2025-01-30', 30, 1, 2025),
('2025-01-31', 31, 1, 2025);

INSERT INTO fact_sales (date_id, store_id, product_id, customer_id, quantity, total_amount)
SELECT
    DATE_ADD('2025-01-01', INTERVAL (n % 31) DAY),   -- dates in January 2025
    ((n % 30) + 1),                                  -- store_id from 1 to 30
    ((n % 30) + 1),                                  -- product_id from 1 to 30
    ((n % 30) + 1),                                  -- customer_id from 1 to 30
    ((n % 5) + 1),                                   -- quantity between 1 and 5
    ROUND(((n % 5) + 1) * (1.2 + (n % 4)), 2)       -- total_amount calculation
FROM (
    SELECT 0 n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
    UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9
    UNION ALL SELECT 10 UNION ALL SELECT 11 UNION ALL SELECT 12 UNION ALL SELECT 13 UNION ALL SELECT 14
    UNION ALL SELECT 15 UNION ALL SELECT 16 UNION ALL SELECT 17 UNION ALL SELECT 18 UNION ALL SELECT 19
    UNION ALL SELECT 20 UNION ALL SELECT 21 UNION ALL SELECT 22 UNION ALL SELECT 23 UNION ALL SELECT 24
    UNION ALL SELECT 25 UNION ALL SELECT 26 UNION ALL SELECT 27 UNION ALL SELECT 28 UNION ALL SELECT 29
    UNION ALL SELECT 30 UNION ALL SELECT 31 UNION ALL SELECT 32 UNION ALL SELECT 33 UNION ALL SELECT 34
    UNION ALL SELECT 35 UNION ALL SELECT 36 UNION ALL SELECT 37 UNION ALL SELECT 38 UNION ALL SELECT 39
    UNION ALL SELECT 40 UNION ALL SELECT 41 UNION ALL SELECT 42 UNION ALL SELECT 43 UNION ALL SELECT 44
    UNION ALL SELECT 45 UNION ALL SELECT 46 UNION ALL SELECT 47 UNION ALL SELECT 48 UNION ALL SELECT 49
    UNION ALL SELECT 50 UNION ALL SELECT 51 UNION ALL SELECT 52 UNION ALL SELECT 53 UNION ALL SELECT 54
    UNION ALL SELECT 55 UNION ALL SELECT 56 UNION ALL SELECT 57 UNION ALL SELECT 58 UNION ALL SELECT 59
    UNION ALL SELECT 60 UNION ALL SELECT 61 UNION ALL SELECT 62 UNION ALL SELECT 63 UNION ALL SELECT 64
    UNION ALL SELECT 65 UNION ALL SELECT 66 UNION ALL SELECT 67 UNION ALL SELECT 68 UNION ALL SELECT 69
    UNION ALL SELECT 70 UNION ALL SELECT 71 UNION ALL SELECT 72 UNION ALL SELECT 73 UNION ALL SELECT 74
    UNION ALL SELECT 75 UNION ALL SELECT 76 UNION ALL SELECT 77 UNION ALL SELECT 78 UNION ALL SELECT 79
    UNION ALL SELECT 80 UNION ALL SELECT 81 UNION ALL SELECT 82 UNION ALL SELECT 83 UNION ALL SELECT 84
    UNION ALL SELECT 85 UNION ALL SELECT 86 UNION ALL SELECT 87 UNION ALL SELECT 88 UNION ALL SELECT 89
    UNION ALL SELECT 90 UNION ALL SELECT 91 UNION ALL SELECT 92 UNION ALL SELECT 93 UNION ALL SELECT 94
    UNION ALL SELECT 95 UNION ALL SELECT 96 UNION ALL SELECT 97 UNION ALL SELECT 98 UNION ALL SELECT 99
) nums;

COMMIT;














