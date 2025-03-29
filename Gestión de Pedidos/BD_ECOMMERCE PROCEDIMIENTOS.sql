USE BD_ECOMMERCE
GO

CREATE PROCEDURE SP_RegistrarPedido
    @IdCliente INT,
    @Productos NVARCHAR(MAX) -- Recibe un JSON en formato de texto
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @IdPedido INT;
    DECLARE @IdProducto INT;
    DECLARE @Cantidad INT;
    DECLARE @Precio DECIMAL(10,2);

    -- 1?? Crear el pedido
    INSERT INTO Pedidos (IdCliente, IdEstado, Total)
    VALUES (@IdCliente, 1, 0); -- Estado "Pendiente"

    SET @IdPedido = SCOPE_IDENTITY();

    -- 2?? Insertar productos en el detalle
    DECLARE @Cursor CURSOR;
    SET @Cursor = CURSOR FOR 
    SELECT IdProducto, Cantidad FROM OPENJSON(@Productos) 
    WITH (IdProducto INT, Cantidad INT);

    OPEN @Cursor;
    FETCH NEXT FROM @Cursor INTO @IdProducto, @Cantidad;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Obtener precio del producto
        SELECT @Precio = Precio FROM Productos WHERE IdProducto = @IdProducto;

        -- Insertar detalle del pedido
        INSERT INTO DetallePedidos (IdPedido, IdProducto, Cantidad, PrecioUnitario)
        VALUES (@IdPedido, @IdProducto, @Cantidad, @Precio);

        -- Actualizar stock
        UPDATE Productos SET Stock = Stock - @Cantidad WHERE IdProducto = @IdProducto;

        FETCH NEXT FROM @Cursor INTO @IdProducto, @Cantidad;
    END;

    CLOSE @Cursor;
    DEALLOCATE @Cursor;

    -- 3?? Calcular el total del pedido
    UPDATE Pedidos SET Total = (
        SELECT SUM(Subtotal) FROM DetallePedidos WHERE IdPedido = @IdPedido
    ) WHERE IdPedido = @IdPedido;
    
    -- Retornar el ID del nuevo pedido
    SELECT @IdPedido AS NuevoPedido;
END;



-- ACTUALIZAR EL ESTADO DE UN PEDIDO --

CREATE PROCEDURE SP_ActualizarEstadoPedido
    @IdPedido INT,
    @NuevoEstado INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Verificar si el pedido existe
    IF NOT EXISTS (SELECT 1 FROM Pedidos WHERE IdPedido = @IdPedido)
    BEGIN
        PRINT 'El pedido no existe';
        RETURN;
    END;

    -- Actualizar estado
    UPDATE Pedidos SET IdEstado = @NuevoEstado WHERE IdPedido = @IdPedido;
END;

-- CONSULTAR PEDIDOS DE UN CLIENTE --

CREATE PROCEDURE SP_ObtenerPedidosCliente
    @IdCliente INT
AS
BEGIN
    SELECT P.IdPedido, P.FechaPedido, E.Estado, P.Total
    FROM Pedidos P
    INNER JOIN EstadosPedido E ON P.IdEstado = E.IdEstado
    WHERE P.IdCliente = @IdCliente;
END;


--TRIGGER PARA VALIDAR STOCK ANTES DE CONFIRMAR UN PEDIDO --

CREATE TRIGGER TR_VerificarStock
ON DetallePedidos
AFTER INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1 FROM inserted i
        JOIN Productos p ON i.IdProducto = p.IdProducto
        WHERE i.Cantidad > p.Stock
    )
    BEGIN
        PRINT 'No hay suficiente stock para este producto';
        ROLLBACK TRANSACTION;
    END;
END;

-- ÍNDICES PARA OPTIMIZAR BUSQUEDAS --

CREATE INDEX IX_Cliente ON Pedidos (IdCliente);
CREATE INDEX IX_EstadoPedido ON Pedidos (IdEstado);
CREATE INDEX IX_ProductoStock ON Productos (Stock);

