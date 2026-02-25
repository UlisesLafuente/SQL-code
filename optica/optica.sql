
CREATE DATABASE IF NOT EXISTS optica_db;

USE optica_db;

CREATE TABLE IF NOT EXISTS direcciones (
    id_direccion INT AUTO_INCREMENT PRIMARY KEY,
    street VARCHAR(255) NOT NULL,
    numero VARCHAR(20) NOT NULL,
    piso VARCHAR(20),
    puerta VARCHAR(20),
    ciudad VARCHAR(255) NOT NULL,
    codigo_postal VARCHAR(10) NOT NULL,
    pais VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS proveedores (
    id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    telefono VARCHAR(20),
    fax VARCHAR(20),
    nif VARCHAR(20) UNIQUE,
    id_direccion INT UNIQUE,
    FOREIGN KEY (id_direccion) REFERENCES direcciones(id_direccion)
);

CREATE TABLE marcas (
    id_marca INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL UNIQUE,
    id_proveedor INT NOT NULL,
    FOREIGN KEY (id_proveedor) REFERENCES proveedores(id_proveedor)
);

CREATE TABLE gafas (
    id_gafa INT AUTO_INCREMENT PRIMARY KEY,
    id_marca INT NOT NULL,
    graduation_right DECIMAL(5,2),
    graduation_left DECIMAL(5,2),
    tipo_marco VARCHAR(255) NOT NULL,
    color_marco VARCHAR(255),
    color_right_glass VARCHAR(255),
    color_left_glass VARCHAR(255),
    precio DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_marca) REFERENCES marcas(id_marca)
);
