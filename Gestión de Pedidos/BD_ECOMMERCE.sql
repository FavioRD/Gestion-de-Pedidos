CREATE DATABASE BD_ECOMMERCE;
GO
USE BD_ECOMMERCE;
GO

-- Tabla Clientes
CREATE TABLE Clientes (
    IdCliente INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    Telefono NVARCHAR(20),
    Direccion NVARCHAR(255)
);

-- Tabla Productos
CREATE TABLE Productos (
    IdProducto INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    Precio DECIMAL(10,2) NOT NULL,
    Stock INT NOT NULL CHECK (Stock >= 0),
    Descripcion NVARCHAR(255)
);

-- Tabla EstadosPedido (Pendiente, Enviado, Entregado, Cancelado)
CREATE TABLE EstadosPedido (
    IdEstado INT IDENTITY(1,1) PRIMARY KEY,
    Estado NVARCHAR(50) UNIQUE NOT NULL
);

-- Tabla Pedidos
CREATE TABLE Pedidos (
    IdPedido INT IDENTITY(1,1) PRIMARY KEY,
    IdCliente INT NOT NULL,
    FechaPedido DATETIME DEFAULT GETDATE(),
    IdEstado INT NOT NULL,
    Total DECIMAL(10,2) DEFAULT 0,
    FOREIGN KEY (IdCliente) REFERENCES Clientes(IdCliente),
    FOREIGN KEY (IdEstado) REFERENCES EstadosPedido(IdEstado)
);

-- Tabla DetallePedidos
CREATE TABLE DetallePedidos (
    IdDetalle INT IDENTITY(1,1) PRIMARY KEY,
    IdPedido INT NOT NULL,
    IdProducto INT NOT NULL,
    Cantidad INT NOT NULL CHECK (Cantidad > 0),
    PrecioUnitario DECIMAL(10,2) NOT NULL,
    Subtotal AS (Cantidad * PrecioUnitario) PERSISTED,
    FOREIGN KEY (IdPedido) REFERENCES Pedidos(IdPedido),
    FOREIGN KEY (IdProducto) REFERENCES Productos(IdProducto)
);

-- Tabla Pagos
CREATE TABLE Pagos (
    IdPago INT IDENTITY(1,1) PRIMARY KEY,
    IdPedido INT NOT NULL,
    Monto DECIMAL(10,2) NOT NULL,
    FechaPago DATETIME DEFAULT GETDATE(),
    MetodoPago NVARCHAR(50) NOT NULL,
    FOREIGN KEY (IdPedido) REFERENCES Pedidos(IdPedido)
);


INSERT INTO EstadosPedido (Estado) VALUES ('Pendiente'), ('Enviado'), ('Entregado'), ('Cancelado');

