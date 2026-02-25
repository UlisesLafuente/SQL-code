
CREATE DATABASE IF NOT EXISTS pizzeria_db;

USE pizzeria_db;

CREATE TABLE IF NOT EXISTS locality_provincia (
    id_locality INT AUTO_INCREMENT PRIMARY KEY,
    locality VARCHAR(255) NOT NULL,
    province VARCHAR(255) NOT NULL,
    UNIQUE(locality, province)
);

CREATE TABLE IF NOT EXISTS clients (
    id_client INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    surname VARCHAR(20) NOT NULL,
    address VARCHAR(20) NOT NULL,
    id_locality INT NOT NULL,
    codigo_postal VARCHAR(10) NOT NULL,
    pais VARCHAR(255) NOT NULL,
    CONSTRAINT fk_client_locality
        FOREIGN KEY (id_locality)
        REFERENCES locality_provincia(id_locality)
);

CREATE TABLE IF NOT EXISTS orders (
    id_order INT AUTO_INCREMENT PRIMARY KEY,
    id_client INT NOT NULL,
    id_store INT NOT NULL,
    order_datetime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    order_type ENUM('delivery', 'pickup') NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,

    delivery_employee_id INT NULL,
    delivery_datetime TIMESTAMP NULL,

    CONSTRAINT fk_order_client
        FOREIGN KEY (id_client)
        REFERENCES clients(id_client),

    CONSTRAINT fk_order_store
        FOREIGN KEY (id_store)
        REFERENCES stores(id_store),

    CONSTRAINT fk_order_delivery_employee
        FOREIGN KEY (delivery_employee_id)
        REFERENCES employees(id_employee)
);

CREATE TABLE IF NOT EXISTS pizza_categories (
    id_category INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS products (
    id_product INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    image VARCHAR(255),
    price DECIMAL(10,2) NOT NULL,
    product_type ENUM('pizza', 'hamburger', 'drink') NOT NULL,
    id_pizza_category INT NULL,

    CONSTRAINT fk_product_category
        FOREIGN KEY (id_pizza_category)
        REFERENCES pizza_categories(id_category)
);

CREATE TABLE IF NOT EXISTS stores (
    id_store INT AUTO_INCREMENT PRIMARY KEY,
    address VARCHAR(255) NOT NULL,
    postcode VARCHAR(10) NOT NULL,
    locality VARCHAR(255) NOT NULL,
    province VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS employees (
    id_employee INT AUTO_INCREMENT PRIMARY KEY,
    id_store INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    surnames VARCHAR(255) NOT NULL,
    nif VARCHAR(20) NOT NULL UNIQUE,
    telephone VARCHAR(20),
    role ENUM('cook', 'delivery') NOT NULL,

    CONSTRAINT fk_employee_store
        FOREIGN KEY (id_store)
        REFERENCES stores(id_store)
);
