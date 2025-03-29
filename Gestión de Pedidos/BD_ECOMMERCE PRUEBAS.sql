USE BD_ECOMMERCE
go

/*INSERTAR DATOS*/

INSERT INTO Clientes (Nombre, Email, Telefono, Direccion) 
VALUES 
('Juan Pérez', 'juan@email.com', '999888777', 'Av. Principal 123'),
('María López', 'maria@email.com', '999777666', 'Calle Secundaria 456');

INSERT INTO Productos (Nombre, Precio, Stock, Descripcion) 
VALUES 
('Laptop Gamer', 2500.00, 10, 'Laptop con RTX 4060'),
('Teclado Mecánico', 80.00, 20, 'Teclado RGB'),
('Mouse Inalámbrico', 40.00, 15, 'Mouse Bluetooth');

SELECT * FROM Clientes;
SELECT * FROM Productos;

/*REGISTRAR UN PEDIDO CON PRODUCTOS*/

DECLARE @JSON NVARCHAR(MAX) = 
'[
    {"IdProducto": 1, "Cantidad": 1},
    {"IdProducto": 3, "Cantidad": 2}
]';

EXEC SP_RegistrarPedido @IdCliente = 1, @Productos = @JSON;


/*Verificar los Datos del Pedido Registrado*/

--Verificar que el pedido se haya creado
SELECT * FROM Pedidos;
--Verificar que los detalles del pedido sean correctos
SELECT * FROM DetallePedidos;
--Verificar que el stock se haya actualizado
SELECT * FROM Productos;


/*ACTUALIZAR EL ESTADO DEL PEDIDO*/
EXEC SP_ActualizarEstadoPedido @IdPedido = 1, @NuevoEstado = 2;

--Verificar el Cambio de Estado
SELECT P.IdPedido, P.FechaPedido, E.Estado 
FROM Pedidos P
INNER JOIN EstadosPedido E ON P.IdEstado = E.IdEstado;



/*OBTENER LOS DATOS DEL PEDIDO DE UN CLIENTE*/
EXEC SP_ObtenerPedidosCliente @IdCliente = 1;



/*Intentar Comprar más de lo Disponible*/
DECLARE @JSON NVARCHAR(MAX) = 
'[
    {"IdProducto": 1, "Cantidad": 100}
]';

EXEC SP_RegistrarPedido @IdCliente = 2, @Productos = @JSON;
