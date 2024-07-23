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
