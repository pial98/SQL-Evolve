DROP DATABASE IF EXISTS retail_sales;
CREATE DATABASE retail_sales;
USE retail_sales;

DROP TABLE IF EXISTS fact_sales;
DROP TABLE IF EXISTS store;
DROP TABLE IF EXISTS product;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS calendar;
DROP TABLE IF EXISTS province;

CREATE TABLE IF NOT EXISTS store (
    store_id INT PRIMARY KEY AUTO_INCREMENT,
    store_name VARCHAR(100) NOT NULL,
    province VARCHAR(50) NOT NULL,
    opened_date DATE NOT NULL 
    
);

CREATE TABLE province (
    province_id INT AUTO_INCREMENT PRIMARY KEY,
    province_name VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS product (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    unit_price DECIMAL(10,2) CHECK (unit_price > 0)
);

CREATE TABLE IF NOT EXISTS customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    gender CHAR(1) CHECK (gender IN ('M','F')),
    age INT CHECK (age BETWEEN 10 AND 100)
);

CREATE TABLE IF NOT EXISTS calendar (
    date_id DATE PRIMARY KEY,
    day INT NOT NULL,
    month INT NOT NULL,
    year INT NOT NULL
);

CREATE TABLE IF NOT EXISTS fact_sales (
    sale_id INT AUTO_INCREMENT PRIMARY KEY,
    date_id DATE NOT NULL,
    store_id INT NOT NULL,
    product_id INT NOT NULL,
    customer_id INT NOT NULL,
    quantity INT CHECK (quantity > 0),
    total_amount DECIMAL(10,2) CHECK (total_amount >= 0),

    FOREIGN KEY (date_id) REFERENCES calendar(date_id),
    FOREIGN KEY (store_id) REFERENCES store(store_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

-- Index 
-- Index to speed up date-based filtering and joins on fact_sales,
-- It is usefull especially for time-series analysis and daily/monthly revenue queries

CREATE INDEX idx_fact_sales_date ON fact_sales(date_id);















