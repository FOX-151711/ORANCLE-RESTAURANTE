--Funciones

--Función para calcular el precio total de una reservación
CREATE OR REPLACE FUNCTION CalcularPrecioTotal(
    p_TN_NumReservacion INT
) RETURN DECIMAL IS
    v_Total DECIMAL(19, 2);
BEGIN
    SELECT SUM(m.TD_Precio * r.TN_Cantidad)
    INTO v_Total
    FROM TREST_RESERVACION r
    JOIN TREST_MENU m ON r.TN_IdMenu = m.TN_IdMenu
    WHERE r.TN_NumReservacion = p_TN_NumReservacion;

    RETURN v_Total;
END;
/
--Funcion para obtener informacion de una reservacion
CREATE OR REPLACE FUNCTION ObtenerInfoReservacion(
    p_TN_NumReservacion INT
) RETURN SYS_REFCURSOR IS
    v_Cursor SYS_REFCURSOR;
BEGIN
    OPEN v_Cursor FOR
        SELECT r.TN_NumReservacion, r.TN_IdCliente, r.TN_IdMesa, r.TN_IdMenu, r.TN_Cantidad, r.TF_FecReserva,
               c.TC_Nombre, c.TC_Ap1, c.TC_Ap2, c.TC_NumTelefono, c.TC_CorreoElectronico,
               m.TC_DscMesa,
               menu.TC_DscMenu, menu.TD_Precio
        FROM TREST_RESERVACION r
        JOIN TREST_CLIENTES c ON r.TN_IdCliente = c.TN_IdCliente
        JOIN TREST_MESAS m ON r.TN_IdMesa = m.TN_IdMesa
        JOIN TREST_MENU menu ON r.TN_IdMenu = menu.TN_IdMenu
        WHERE r.TN_NumReservacion = p_TN_NumReservacion;

    RETURN v_Cursor;
END;


--Funcion para calcular el total de clientes registrados
CREATE OR REPLACE FUNCTION ContarClientesRegistrados
RETURN INT IS
    v_TotalClientes INT;
BEGIN
    SELECT COUNT(*)
    INTO v_TotalClientes
    FROM TREST_CLIENTES;

    RETURN v_TotalClientes;
END;


--Funcion para obtener el nombre del cliente que hizo una reservacion 
CREATE OR REPLACE FUNCTION ObtenerNombreCliente(
    p_TN_NumReservacion INT
) RETURN VARCHAR2 IS
    v_NombreCliente VARCHAR2(60);
BEGIN
    SELECT c.TC_Nombre
    INTO v_NombreCliente
    FROM TREST_CLIENTES c
    JOIN TREST_RESERVACION r ON c.TN_IdCliente = r.TN_IdCliente
    WHERE r.TN_NumReservacion = p_TN_NumReservacion;

    RETURN v_NombreCliente;
END;


--Función para Reporte de Reservaciones, Cliente, Mesa
CREATE OR REPLACE FUNCTION ReporteReservacionesClientesMesas
RETURN SYS_REFCURSOR IS
    v_Cursor SYS_REFCURSOR;
BEGIN
    OPEN v_Cursor FOR
        SELECT r.TN_NumReservacion, c.TC_Nombre, c.TC_Ap1, c.TC_Ap2, m.TC_DscMesa, r.TF_FecReserva
        FROM TREST_RESERVACION r
        JOIN TREST_CLIENTES c ON r.TN_IdCliente = c.TN_IdCliente
        JOIN TREST_MESAS m ON r.TN_IdMesa = m.TN_IdMesa;
    RETURN v_Cursor;
END;
/

--Función para Calcular el Precio Total de una Reservación

CREATE OR REPLACE FUNCTION CalcularPrecioTotal(
    p_TN_NumReservacion INT
) RETURN DECIMAL IS
    v_Total DECIMAL(19, 2);
BEGIN
    SELECT SUM(m.TD_Precio * r.TN_Cantidad)
    INTO v_Total
    FROM TREST_RESERVACION r
    JOIN TREST_MENU m ON r.TN_IdMenu = m.TN_IdMenu
    WHERE r.TN_NumReservacion = p_TN_NumReservacion;

    RETURN v_Total;
END;
/
