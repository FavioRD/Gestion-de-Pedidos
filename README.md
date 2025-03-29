📦 Sistema de Gestión de Pedidos con SQL Server

Este proyecto implementa un sistema de gestión de pedidos utilizando SQL Server, con procedimientos almacenados para registrar pedidos, gestionar detalles, actualizar stock y cambiar el estado de los pedidos.

🚀 Características

Registro de pedidos con múltiples productos en formato JSON.

Cálculo automático del total del pedido.

Descuento automático de stock al registrar un pedido.

Validación para evitar ventas sin stock.

Actualización del estado del pedido (Pendiente, Enviado, Entregado).

Listado de pedidos por cliente.

📂 Estructura de Tablas

🛒 Tabla: Pedidos

📑 Tabla: DetallePedidos

🛍️ Tabla: Productos

👤 Tabla: Clientes


🛠️ Procedimientos Almacenados

🔹 Registrar un Pedido

EXEC SP_RegistrarPedido @IdCliente = 1, @Productos = '[{"IdProducto":1, "Cantidad":2}, {"IdProducto":3, "Cantidad":1}]';

🔹 Actualizar Estado del Pedido

EXEC SP_ActualizarEstadoPedido @IdPedido = 1, @NuevoEstado = 2;

🔹 Obtener Pedidos de un Cliente

EXEC SP_ObtenerPedidosCliente @IdCliente = 1;

🧪 Pruebas y Validaciones

Insertar clientes y productos.

Registrar un pedido con productos en formato JSON.

Validar que el pedido se creó correctamente.

Verificar la reducción de stock de los productos comprados.

Actualizar el estado del pedido.

Intentar registrar una compra sin stock disponible.

