# 📦 Sistema de Gestión de Pedidos con SQL Server

Este proyecto implementa un **Sistema de Gestión de Pedidos** utilizando **SQL Server**, con procedimientos almacenados para registrar pedidos, gestionar detalles, actualizar stock y cambiar el estado de los pedidos.

## 🚀 Características

- 📋 **Registro de pedidos** con múltiples productos en formato JSON.
- 💰 **Cálculo automático** del total del pedido.
- 📉 **Descuento automático de stock** al registrar un pedido.
- ⚠️ **Validación para evitar ventas sin stock disponible.**
- 🔄 **Actualización del estado del pedido** *(Pendiente, Enviado, Entregado).*
- 📜 **Listado de pedidos por cliente.**

---

## 📂 Estructura de Tablas

| 📌 Tabla         | Descripción |
|----------------|-------------|
| 🛒 **Pedidos**  | Almacena los pedidos realizados. |
| 📑 **DetallePedidos** | Registra los productos incluidos en cada pedido. |
| 🛍️ **Productos** | Contiene información sobre los productos disponibles. |
| 👤 **Clientes**  | Guarda los datos de los clientes. |

---

## 🛠️ Procedimientos Almacenados

### 🔹 Registrar un Pedido
```sql
EXEC SP_RegistrarPedido @IdCliente = 1, @Productos = '[{"IdProducto":1, "Cantidad":2}, {"IdProducto":3, "Cantidad":1}]';
```

### 🔹 Actualizar Estado del Pedido
```sql
EXEC SP_ActualizarEstadoPedido @IdPedido = 1, @NuevoEstado = 2;
```

### 🔹 Obtener Pedidos de un Cliente
```sql
EXEC SP_ObtenerPedidosCliente @IdCliente = 1;
```

---

## 🧪 Pruebas y Validaciones

✅ **Insertar clientes y productos en la base de datos.**

✅ **Registrar un pedido con productos en formato JSON.**

✅ **Validar que el pedido se haya creado correctamente.**

✅ **Verificar la reducción del stock de los productos comprados.**

✅ **Actualizar el estado de un pedido y comprobar su modificación.**

❌ **Intentar registrar una compra sin stock disponible y validar el mensaje de error.**

---

## 📌 Notas Adicionales
- Es recomendable contar con **SQL Server 2019 o superior** para ejecutar este sistema.
- La estructura de las tablas y los procedimientos almacenados deben crearse antes de ejecutar las pruebas.
- Se puede ampliar la funcionalidad incluyendo reportes y dashboards de pedidos.

---

💡 **Contribuciones y mejoras son bienvenidas!** ✨

