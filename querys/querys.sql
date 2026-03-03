-- 1. List the name of all products in the product table.

SELECT nombre FROM tienda.producto;

-- 2. List the names and prices of all products in the product table.

SELECT nombre, precio FROM tienda.producto;

-- 3. List all columns in the product table.

SELECT * FROM tienda.producto;

-- 4. List the name of the products, the price in euros (precio_eur) and the price in US dollars (precio_usd) with a exchange rate of 1 € = 1 $.

SELECT
    nombre,
    precio AS precio_eur,
    precio * 1 AS precio_usd
FROM tienda.producto;

-- 5. List the name of the products, the price in euros and the price in US dollars (with a exchange rate of 1 € = 1.1 $ and rounding the result to two decimal digits). Use the following aliases for the columns: product name, euros, dollars.

SELECT
    nombre,
    precio AS euros,
    ROUND(precio * 1.1 ,2) AS dollars
FROM tienda.producto;

-- 6. List the names (number) and prices of all products in the product table, converting the names to capital letters.

SELECT
    UPPER(nombre) AS nombre,
    precio
FROM tienda.producto;

-- 7. List the names (number) and prices (precio) of the products in the product table, converting the names to lowercase.

SELECT
    LOWER(nombre) AS nombre,
    precio
FROM tienda.producto;

-- 8. List the name of all manufacturers in one column, and in another column get in capital letters the first two characters of the manufacturer's name (iniciales).

SELECT
  nombre AS NombreFabricante,
  UPPER(LEFT(nombre, 2)) AS Iniciales
FROM tienda.fabricante;

--9. List the names and prices of the products, rounding up the price value (price)

SELECT
    LOWER(nombre) AS nombre,
    precio
FROM tienda.producto;

-- 10. List the names and prices of all products (precio truncado) of the product table, truncating the value of the price to display it without any decimal digits.

SELECT
    nombre,
    CAST(precio AS DECIMAL(5,0)) AS precio_truncado
FROM tienda.producto;

-- 11. Displays a list with the manufacturer codes that appear in the product table, including possible repetitions.
SELECT
    codigo_fabricante
FROM tienda.producto;


-- 12. List the code of the manufacturers that have products in the product table, eliminating the codes that appear repeated.

SELECT
    DISTINCT codigo_fabricante
FROM tienda.producto;

-- 13. List the names of the manufacturers sorted upwards

SELECT
	fabricante.nombre
FROM tienda.fabricante
ORDER BY nombre;

-- 14. List the names of the manufacturers sorted down mode

SELECT
	fabricante.nombre
FROM tienda.fabricante
ORDER BY nombre DESC;

-- 15. List the names and prices of the products ordered, firstly, by the name ascending and, secondly, by the price of descending manner.

SELECT
    nombre,
    precio
FROM tienda.producto
ORDER BY nombre ASC, precio DESC;

-- 16. Returns a list with the top 5 rows of the manufacturing table.

SELECT *
FROM tienda.fabricante
LIMIT 5;

-- 17. Returns a list with 2 rows from the fourth row of the manufacturing table. The fourth row should also be included in the answer.

SELECT *
FROM tienda.fabricante
LIMIT 2 OFFSET 3;

--18. List the cheapest name and price of the product. (Use only the ORDER BY and LIMIT clauses).

SELECT
    nombre,
    precio
FROM tienda.producto
ORDER BY precio ASC
LIMIT 1;

--19. List the name and price of the most expensive product. (Use only the ORDER BY and LIMIT clauses).

SELECT
    nombre,
    precio
FROM tienda.producto
ORDER BY precio DESC
LIMIT 1;

--20. List the name of all manufacturer products whose manufacturer code is equal to 2.

SELECT producto.nombre
FROM tienda.producto
WHERE codigo_fabricante =2;

-- 21. Returns a list with the product name, price and manufacturer name (manufacturer number) of all products in the database.

SELECT
    producto.nombre,
    fabricante.nombre
FROM
    tienda.producto
INNER JOIN
    tienda.fabricante ON producto.codigo_fabricante = fabricante.codigo;

- 22. List all products with manufacturer name, price and name (manufacturer number) sorted alphabetically.

SELECT
    producto.nombre,
    producto.precio,
    fabricante.nombre
FROM
    tienda.producto
INNER JOIN
    tienda.fabricante ON producto.codigo_fabricante = fabricante.codigo
ORDER BY producto.nombre;

-- 23. Returns a list with the product code, product name, manufacturer code (codigo manufacturere) and manufacturer name (manufacturer number), of all products in the database.

SELECT
    producto.codigo,
    producto.nombre,
    producto.codigo_fabricante,
    fabricante.nombre
FROM
    tienda.producto
INNER JOIN
    tienda.fabricante ON producto.codigo_fabricante = fabricante.codigo;

-- 24. Returns the name, price and name of the manufacturer, of the cheapest product.

SELECT
    producto.nombre,
    producto.precio,
    fabricante.nombre
FROM
    tienda.producto
INNER JOIN
    tienda.fabricante ON producto.codigo_fabricante = fabricante.codigo
ORDER BY precio
LIMIT 1;

-- 25. Returns the name of the product, the price and the name of its manufacturer, of the most expensive product.

SELECT
    producto.nombre,
    producto.precio,
    fabricante.nombre
FROM
    tienda.producto
INNER JOIN
    tienda.fabricante ON producto.codigo_fabricante = fabricante.codigo
ORDER BY precio DESC
LIMIT 1;

-- 26. Returns a list with name and price of all products from the manufacturer Lenovo.

SELECT
    producto.nombre,
    producto.precio,
    fabricante.nombre
FROM
    tienda.producto
INNER JOIN
    tienda.fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre = 'lenovo';

-- 27. Returns a list with name and price of all products from the manufacturer Crucial that have a price greater than € 200

SELECT
    producto.nombre,
    producto.precio,
    fabricante.nombre
FROM
    tienda.producto
INNER JOIN
    tienda.fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre = 'crucial' AND producto.precio > 200;

-- 28. Returns a list with name, price and name of the manufacturer (manufacturer) of all products from the manufacturers Asus, Hewlett-Packard and Seagate. Without using the IN operator.

SELECT
    producto.nombre,
    producto.precio,
    fabricante.nombre
FROM
    tienda.producto
INNER JOIN
    tienda.fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre = 'asus' OR fabricante.nombre = 'hewlett-packard' OR fabricante.nombre = 'seagate';

-- 29. Returns a list with name, price and name of the manufacturer (manufacturer) of all products from the manufacturers Asus, Hewlett-Packard and Seagate. Using the operator IN.

SELECT
    producto.nombre,
    producto.precio,
    fabricante.nombre
FROM
    tienda.producto
INNER JOIN
    tienda.fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre IN ('asus', 'hewlett-packard', 'seagate');

--30. Returns a list with the name, price and name of the manufacturer of the products, where the name of the manufacturer ends in the letter 'e'.

SELECT
    producto.nombre,
    producto.precio,
    fabricante.nombre
FROM
    tienda.producto
INNER JOIN
    tienda.fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre LIKE '%e';

-- 31. Returns a list with the name of the product, its price and the name of the manufacturer, for all those products whose manufacturers contain the letter 'w' in their name.

SELECT
    producto.nombre,
    producto.precio,
    fabricante.nombre
FROM
    tienda.producto
INNER JOIN
    tienda.fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre LIKE '%w%';

-- 32. Returns a list with the name of the product, its price and the name of the manufacturer, for all products with a price equal to or greater than 180 €. Sort the results, first by price in descending order and then by product name in ascending order.

SELECT
    producto.nombre,
    producto.precio,
    fabricante.nombre
FROM
    tienda.producto
INNER JOIN
    tienda.fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE producto.precio >= 180
ORDER BY producto.precio DESC, producto.nombre ASC;

-- 33. Returns a list with the code and the name of manufacturer, only of those manufacturers that have associated products in the database.

SELECT DISTINCT
    fabricante.codigo,
    fabricante.nombre
FROM
    tienda.fabricante
INNER JOIN
    tienda.producto
ON
    fabricante.codigo = producto.codigo_fabricante;

-- 34. Returns a list of all the manufacturers that exist in the database, along with the products that each of them has. It also includes manufacturers that do not have any products. Shows the name of the manufacturer (manufacturer) and the name of the product (product).

SELECT
    f.nombre AS fabricante,
    p.nombre AS producto
FROM
    tienda.fabricante f
LEFT JOIN
    tienda.producto p
ON
    f.codigo = p.codigo_fabricante;

-- 35. Returns a list where only the names of the manufacturers (manufacturer) that have no associated product appear.

SELECT
    f.nombre AS fabricante
FROM
    tienda.fabricante f
LEFT JOIN
    tienda.producto p
ON
    f.codigo = p.codigo_fabricante
WHERE
    p.codigo IS NULL;

-- 36. Returns all products from the manufacturer Lenovo. (No use inNER JOIN).

SELECT
    producto.nombre,
    producto.precio
FROM
    tienda.producto
WHERE producto.codigo_fabricante = (SELECT codigo FROM tienda.fabricante WHERE nombre = 'lenovo');

- 37. Returns all the data of the products that have the same price as the most expensive product of the manufacturer Lenovo. (No use inNER JOIN).

SELECT *
FROM tienda.producto
WHERE precio = (
    SELECT MAX(precio)
    FROM tienda.producto
    WHERE codigo_fabricante = (
        SELECT codigo
        FROM tienda.fabricante
        WHERE nombre = 'lenovo'
    )
);

-- 38. List the most expensive product name of Lenovo manufacturer.

SELECT nombre, precio
FROM tienda.producto
WHERE precio = (
    SELECT MAX(precio)
    FROM tienda.producto
    WHERE codigo_fabricante = (
        SELECT codigo
        FROM tienda.fabricante
        WHERE nombre = 'Lenovo'
    )
);

-- 39. List the cheapest product name from manufacturer Hewlett-Packard.

SELECT nombre, precio
FROM tienda.producto
WHERE precio = (
    SELECT MIN(precio)
    FROM tienda.producto
    WHERE codigo_fabricante = (
        SELECT codigo
        FROM tienda.fabricante
        WHERE nombre = 'Hewlett-Packard'
    )
);

-- 40. Returns all products from the database that are priced higher or equal to the most expensive product from the manufacturer Lenovo.

SELECT nombre, precio
FROM tienda.producto
WHERE precio >= (
    SELECT MAX(precio)
    FROM tienda.producto
    WHERE codigo_fabricante = (
        SELECT codigo
        FROM tienda.fabricante
        WHERE nombre = 'Lenovo'
    )
);

-- 41. List all products from manufacturer Asus that are higher than the average price of all your products.

SELECT *
FROM tienda.producto
JOIN tienda.fabricante
ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre = 'Asus'
AND producto.precio > (
    SELECT AVG(precio)
    FROM tienda.producto
);

