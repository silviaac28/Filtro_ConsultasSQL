CREATE DATABASE tech_haven_dbb;
USE tech_haven_dbb;

CREATE TABLE Usuarios (
id INT(11) NOT NULL AUTO_INCREMENT,
nombre VARCHAR(100),
correo_electronico VARCHAR(100),
fecha_registro DATE,
PRIMARY KEY (id)
);

CREATE TABLE Productos(
id INT(11) NOT NULL AUTO_INCREMENT,
nombre VARCHAR(100),
precio DOUBLE(10,2),
descripcion TEXT,
PRIMARY KEY (id)
);

CREATE TABLE Pedidos(
id INT(11) NOT NULL AUTO_INCREMENT,
id_usuario INT(11),
fecha DATE,
total DOUBLE(10,2),
PRIMARY KEY (id),
FOREIGN KEY (id_usuario) REFERENCES Usuarios(id)
);

CREATE TABLE DetallesPedidos(
id_pedido INT(11),
id_producto INT(11),
cantidad INT(11),
precio_unitario DOUBLE(10,2),
PRIMARY KEY (id_pedido, id_producto),
FOREIGN KEY (id_pedido) REFERENCES Pedidos(id),
FOREIGN KEY (id_producto) REFERENCES Productos(id)
);
