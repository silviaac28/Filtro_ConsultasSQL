# Filtro_ConsultasSQL

Este documento contiene las consultas para la base de datos para la tienda en linea "TECH HAVEN"

1. Obtener la lista de todos los productos con sus precio
~~~mysql
SELECT nombre, precio
FROM Productos;


+-------------------------+---------+
| nombre                  | precio  |
+-------------------------+---------+
| iPhone 13               |  799.99 |
| Samsung Galaxy S21      |  699.99 |
| Sony WH-1000XM4         |  349.99 |
| MacBook Pro             | 1299.99 |
| Dell XPS 13             |  999.99 |
| GoPro HERO9             |  399.99 |
| Amazon Echo Dot         |   49.99 |
| Kindle Paperwhite       |  129.99 |
| Apple Watch Series 7    |  399.99 |
| Bose QuietComfort 35 II |  299.99 |
| Nintendo Switch         |  299.99 |
| Fitbit Charge 5         |  179.95 |
| Nintendo Wii            |  499.95 |
+-------------------------+---------+

~~~


2. Encontrar todos los pedidos realizados por un usuario específico, por ejemplo, Juan Perez

~~~mysql
SELECT p.id AS 'ID pedido', p.fecha, p.total
FROM Usuarios AS u
INNER JOIN Pedidos AS p
ON u.id = p.id_usuario
WHERE u.nombre = 'Juan Perez';


+-----------+------------+---------+
| ID pedido | fecha      | total   |
+-----------+------------+---------+
|         1 | 2024-02-25 | 1049.98 |
+-----------+------------+---------+



~~~

3. Listar los detalles de todos los pedidos, incluyendo el nombre del producto, cantidad y precio
unitario
~~~mysql
SELECT dp.id_pedido, pr.nombre, dp.cantidad, dp.precio_unitario
FROM DetallesPedidos AS dp
INNER JOIN Productos AS pr
ON dp.id_producto = pr.id;

+-----------+-------------------------+----------+-----------------+
| id_pedido | nombre                  | cantidad | precio_unitario |
+-----------+-------------------------+----------+-----------------+
|         1 | iPhone 13               |        1 |          799.99 |
|         1 | Amazon Echo Dot         |        5 |           49.99 |
|         2 | MacBook Pro             |        1 |         1299.99 |
|         2 | Kindle Paperwhite       |        1 |          129.99 |
|         3 | Samsung Galaxy S21      |        1 |          699.99 |
|         3 | Apple Watch Series 7    |        1 |          399.99 |
|         4 | Dell XPS 13             |        1 |          999.99 |
|         4 | Bose QuietComfort 35 II |        1 |          299.99 |
|         5 | Sony WH-1000XM4         |        1 |          349.99 |
|         5 | Nintendo Switch         |        1 |          299.99 |
|         6 | GoPro HERO9             |        1 |          399.99 |
+-----------+-------------------------+----------+-----------------+
~~~

4. Calcular el total gastado por cada usuario en todos sus pedidos
~~~mysql
SELECT u.nombre, SUM(p.total) AS total_gastado
FROM Usuarios AS u
INNER JOIN Pedidos AS p
ON u.id = p.id_usuario
GROUP BY u.id;

+----------------+---------------+
| nombre         | total_gastado |
+----------------+---------------+
| Juan Perez     |       1049.98 |
| Maria Lopez    |       1349.98 |
| Carlos Mendoza |       1249.99 |
| Ana Gonzalez   |        449.98 |
| Luis Torres    |        699.99 |
| Laura Rivera   |        399.99 |
+----------------+---------------+
~~~

5. Encontrar los productos más caros (precio mayor a $500)
~~~mysql
SELECT nombre, precio
FROM Productos
WHERE precio > 500;

+--------------------+---------+
| nombre             | precio  |
+--------------------+---------+
| iPhone 13          |  799.99 |
| Samsung Galaxy S21 |  699.99 |
| MacBook Pro        | 1299.99 |
| Dell XPS 13        |  999.99 |
+--------------------+---------+
~~~

6. Listar los pedidos realizados en una fecha específica, por ejemplo, 2024-03-10
~~~mysql
SELECT id, id_usuario, fecha, total
FROM Pedidos
WHERE fecha = '2024-03-10';

+-----------+------------+------------+---------+
| id_pedido | id_usuario | fecha      | total   |
+-----------+------------+------------+---------+
|         2 |          2 | 2024-03-10 | 1349.98 |
+-----------+------------+------------+---------+
~~~

7. Obtener el número total de pedidos realizados por cada usuario
~~~mysql
SELECT u.nombre, COUNT(p.id_usuario) AS numero_pedidos
FROM Usuarios AS u
INNER JOIN Pedidos AS p
ON u.id = p.id_usuario
GROUP BY u.id;
+----------------+----------------+
| nombre         | numero_pedidos |
+----------------+----------------+
| Juan Perez     |              1 |
| Maria Lopez    |              1 |
| Carlos Mendoza |              1 |
| Ana Gonzalez   |              1 |
| Luis Torres    |              1 |
| Laura Rivera   |              1 |
+----------------+----------------+
~~~

8. Encontrar el nombre del producto más vendido (mayor cantidad total vendida)
~~~mysql
SELECT pr.nombre, SUM(dp.cantidad) AS cantidad_total
FROM Productos AS pr
INNER JOIN DetallesPedidos AS dp
ON pr.id= dp.id_producto
GROUP BY dp.id_producto
ORDER BY cantidad_total DESC
LIMIT 1;

+-----------------+----------------+
| nombre          | cantidad_total |
+-----------------+----------------+
| Amazon Echo Dot |              5 |
+-----------------+----------------+
~~~

9. Listar todos los usuarios que han realizado al menos un pedido
~~~mysql
SELECT u.nombre, u.correo_electronico
FROM Usuarios AS u
LEFT JOIN Pedidos AS p
ON u.id = p.id_usuario
WHERE p.id_usuario IS NOT NULL;

+----------------+----------------------------+
| nombre         | correo_electronico         |
+----------------+----------------------------+
| Juan Perez     | juan.perez@example.com     |
| Maria Lopez    | maria.lopez@example.com    |
| Carlos Mendoza | carlos.mendoza@example.com |
| Ana Gonzalez   | ana.gonzalez@example.com   |
| Luis Torres    | luis.torres@example.com    |
| Laura Rivera   | laura.rivera@example.com   |
+----------------+----------------------------+
~~~

10. Obtener los detalles de un pedido específico, incluyendo los productos y cantidades, por
ejemplo, pedido con id 1

~~~mysql
SELECT p.id, u.nombre AS usuario, pr.nombre AS producto, dp.cantidad, dp.precio_unitario
FROM Usuarios AS u
INNER JOIN Pedidos AS p
ON u.id = p.id_usuario
INNER JOIN DetallesPedidos AS dp
ON p.id = dp.id_pedido
INNER JOIN Productos AS pr
ON dp.id_producto = pr.id
WHERE p.id = 1;

+-----------+------------+-----------------+----------+-----------------+
| id_pedido | usuario    | producto        | cantidad | precio_unitario |
+-----------+------------+-----------------+----------+-----------------+
|         1 | Juan Perez | iPhone 13       |        1 |          799.99 |
|         1 | Juan Perez | Amazon Echo Dot |        5 |           49.99 |
+-----------+------------+-----------------+----------+-----------------+
~~~

Subconsultas

1. Encontrar el nombre del usuario que ha gastado más en total

~~~mysql
SELECT u.nombre, SUM(p.total) AS total_gastado
FROM Usuarios AS u
INNER JOIN Pedidos AS p
ON u.id = p.id_usuario
GROUP BY u.id
ORDER BY total_gastado DESC
LIMIT 1;

+-------------+---------------+
| nombre      | total_gastado |
+-------------+---------------+
| Maria Lopez |       1349.98 |
+-------------+---------------+
~~~



2. Listar los productos que han sido pedidos al menos una vez

~~~mysql
SELECT pr.nombre
FROM Productos AS pr
INNER JOIN DetallesPedidos AS dp
ON pr.id = dp.id_producto
WHERE dp.id_producto IN (SELECT id_producto FROM DetallesPedidos);


+-------------------------+
| nombre                  |
+-------------------------+
| iPhone 13               |
| Samsung Galaxy S21      |
| Sony WH-1000XM4         |
| MacBook Pro             |
| Dell XPS 13             |
| GoPro HERO9             |
| Amazon Echo Dot         |
| Kindle Paperwhite       |
| Apple Watch Series 7    |
| Bose QuietComfort 35 II |
| Nintendo Switch         |
+-------------------------+
~~~


3. Obtener los detalles del pedido con el total más alto

~~~mysql
SELECT id, id_usuario, fecha, total
FROM Pedidos 
WHERE total = (SELECT MAX(total) FROM Pedidos);


+-----------+------------+------------+---------+
| id_pedido | id_usuario | fecha      | total   |
+-----------+------------+------------+---------+
|         2 |          2 | 2024-03-10 | 1349.98 |
+-----------+------------+------------+---------+
~~~

4. Listar los usuarios que han realizado más de un pedido

~~~mysql
SELECT u.nombre, u.correo_electronico
FROM Usuarios AS u
INNER JOIN Pedidos AS p
ON u.id = p.id_usuario
GROUP BY u.id
HAVING COUNT(p.id) > 1;

~~~





5. Encontrar el producto más caro que ha sido pedido al menos una vez
~~~mysql
SELECT pr.nombre, pr.precio 
FROM Productos AS pr
INNER JOIN DetallesPedidos AS dp
ON pr.id = dp.id_producto
WHERE pr.precio = (SELECT MAX(precio_unitario) FROM DetallesPedidos);



+-------------+---------+
| nombre      | precio  |
+-------------+---------+
| MacBook Pro | 1299.99 |
+-------------+---------+

~~~

***************************
Procedimientos Almacenados
1. Crear un procedimiento almacenado para agregar un nuevo producto
Enunciado: Crea un procedimiento almacenado llamado AgregarProducto que reciba como
parámetros el nombre, descripción y precio de un nuevo producto y lo inserte en la tabla
Productos .


~~~mysql

DELIMITER $$

DROP PROCEDURE IF EXISTS AgregarProducto;
CREATE PROCEDURE AgregarProducto(
	IN p_nombre VARCHAR(100),
	IN p_precio DOUBLE(10,2),
	IN p_descripcion TEXT
)

BEGIN
	INSERT INTO Productos(nombre, precio, descripcion)
	VALUES (p_nombre, p_precio, p_descripcion);
END $$
DELIMITER;

~~~


2.Crear un procedimiento almacenado para obtener los detalles de un pedido
Enunciado: Crea un procedimiento almacenado llamado ObtenerDetallesPedido que reciba
como parámetro el ID del pedido y devuelva los detalles del pedido, incluyendo el nombre del
producto, cantidad y precio unitario.

~~~mysql

DELIMITER $$

DROP PROCEDURE IF EXISTS ObtenerDetallesPedido;
CREATE PROCEDURE ObtenerDetallesPedido(
	IN p_id_pedido INT
	)

BEGIN
	SELECT dp.id_pedido, pr.nombre AS nombreProducto, dp.cantidad, dp.precio_unitario
	FROM DetallesPedidos AS dp
	INNER JOIN Productos AS pr
	ON dp.id_producto = pr.id
	WHERE id_pedido = p_id_pedido;
END $$

DELIMITER ;

CALL ObtenerDetallesPedido(3);

+-----------+----------------------+----------+-----------------+
| id_pedido | nombreProducto       | cantidad | precio_unitario |
+-----------+----------------------+----------+-----------------+
|         3 | Samsung Galaxy S21   |        1 |          699.99 |
|         3 | Apple Watch Series 7 |        1 |          399.99 |
+-----------+----------------------+----------+-----------------+

~~~

3. Crear un procedimiento almacenado para actualizar el precio de un producto
Enunciado: Crea un procedimiento almacenado llamado ActualizarPrecioProducto que reciba
como parámetros el ID del producto y el nuevo precio, y actualice el precio del producto en la
tabla Productos .

~~~mysql

DELIMITER $$

DROP PROCEDURE IF EXISTS ActualizarPrecioProducto;
CREATE PROCEDURE ActualizarPrecioProducto(
	IN p_id_producto INT,
    IN p_precio DOUBLE
	)

BEGIN
	UPDATE Productos
    SET precio = p_precio
	WHERE id = p_id_producto;
END $$

DELIMITER ;

CALL ActualizarPrecioProducto(2, 699.99);

~~~

4. Crear un procedimiento almacenado para eliminar un producto
Enunciado: Crea un procedimiento almacenado llamado EliminarProducto que reciba como
parámetro el ID del producto y lo elimine de la tabla Productos .

~~~mysql
DELIMITER $$
DROP PROCEDURE IF EXISTS EliminarProducto;
CREATE PROCEDURE EliminarProducto(
    IN p_id_producto INT
)
BEGIN
	DELETE FROM Productos
	WHERE id= p_id_producto;
END $$
DELIMITER ;

CALL EliminarProducto(2);

~~~


5. Crear un procedimiento almacenado para obtener el total gastado por un usuario
Enunciado: Crea un procedimiento almacenado llamado TotalGastadoPorUsuario que reciba
como parámetro el ID del usuario y devuelva el total gastado por ese usuario en todos sus
pedidos.

~~~mysql
DELIMITER $$

DROP PROCEDURE IF EXISTS TotalGastadoPorUsuario;
CREATE PROCEDURE TotalGastadoPorUsuario(
	IN p_id_usuario INT
	)

BEGIN
    SELECT u.nombre, SUM(p.total) AS total_gastado
    FROM Usuarios AS u
    INNER JOIN Pedidos AS p
    ON u.id = p.id_usuario
    WHERE u.id = p_id_usuario
    GROUP BY u.id;
	
END $$

DELIMITER ;

CALL TotalGastadoPorUsuario(4);

~~~

