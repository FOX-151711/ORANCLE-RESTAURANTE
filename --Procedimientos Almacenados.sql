CREATE OR REPLACE PROCEDURE agregar_empleado(
    p_TN_ID_EMPLEADO IN NUMBER,
    p_TC_NOM_EMPLEADO IN VARCHAR2,
    p_TC_AP1_EMPLEADO IN VARCHAR2,
    p_TC_AP2_EMPLEADO IN VARCHAR2
) IS
BEGIN
    INSERT INTO tbl_empleados (TN_ID_EMPLEADO, TC_NOM_EMPLEADO, TC_AP1_EMPLEADO, TC_AP2_EMPLEADO)
    VALUES (p_TN_ID_EMPLEADO, p_TC_NOM_EMPLEADO, p_TC_AP1_EMPLEADO, p_TC_AP2_EMPLEADO);
EXCEPTION
    WHEN OTHERS THEN
        -- Manejo de excepciones
        RAISE;
END;
-----
CREATE OR REPLACE PROCEDURE agregar_articulos(
    p_TN_IDARTICULO IN NUMBER,
    p_TC_DSC_ARTICULO IN VARCHAR2,
    p_TN_PRECIO IN NUMBER,
    p_TN_CATEGORIA IN NUMBER
) IS
BEGIN
    INSERT INTO tbl_articulos (TN_IDARTICULO,TC_DSC_ARTICULO, TN_PRECIO,TN_CATEGORIA)
    VALUES (p_TN_IDARTICULO, p_TC_DSC_ARTICULO, p_TN_PRECIO,p_TN_CATEGORIA);
EXCEPTION
    WHEN OTHERS THEN
        -- Manejo de excepciones
        RAISE;
END;
-----

CREATE OR REPLACE PROCEDURE registrar_reservacion(
    p_TN_NUMRESERVACION IN NUMBER,
    p_TN_IDCLIENTE IN NUMBER,
    p_TN_IDMESA IN NUMBER,
    p_TN_IDMENU IN NUMBER,
    p_TN_CANTIDAD IN NUMBER,
    p_TF_FECRESERVA IN DATE
) IS
BEGIN
    INSERT INTO trest_reservacion (TN_NUMRESERVACION, TN_IDCLIENTE, TN_IDMESA, TN_IDMENU,TN_CANTIDAD, TF_FECRESERVA)
    VALUES (p_TN_NUMRESERVACION,p_TN_IDCLIENTE, p_TN_IDMESA, p_TN_IDMENU,p_TN_CANTIDAD,p_TF_FECRESERVA);
EXCEPTION
    WHEN OTHERS THEN
        -- Manejo de excepciones
        RAISE;
END;
-------
CREATE OR REPLACE PROCEDURE Eliminar_Reservacion (
    p_NumReservacion IN NUMBER
) IS
BEGIN
    DELETE FROM TREST_RESERVACION
    WHERE TN_NumReservacion = p_NumReservacion;
END;
/


------

CREATE OR REPLACE PROCEDURE Insertar_Menu (
    p_TN_IdMenu IN NUMBER,
    p_TC_DscMenu IN VARCHAR2,
    p_TN_IdTipoMenu IN NUMBER,
    p_TD_Precio IN DECIMAL
) IS
BEGIN
    INSERT INTO TREST_MENU (TN_IdMenu, TC_DscMenu, TN_IdTipoMenu, TD_Precio)
    VALUES (p_TN_IdMenu, p_TC_DscMenu, p_TN_IdTipoMenu, p_TD_Precio);
END;
/
----

CREATE OR REPLACE PROCEDURE Actualizar_Cliente (
    p_IdCliente IN NUMBER,
    p_Nombre IN VARCHAR2,
    p_Ap1 IN VARCHAR2,
    p_Ap2 IN VARCHAR2,
    p_NumTelefono IN NUMBER,
    p_CorreoElectronico IN VARCHAR2
) IS
BEGIN
    UPDATE TREST_CLIENTES
    SET TC_Nombre = p_Nombre,
        TC_Ap1 = p_Ap1,
        TC_Ap2 = p_Ap2,
        TC_NumTelefono = p_NumTelefono,
        TC_CorreoElectronico = p_CorreoElectronico
    WHERE TN_IdCliente = p_IdCliente;
END;
/
-----
CREATE OR REPLACE PROCEDURE Obtener_Mesa (
    p_IdMesa IN NUMBER,
    p_DscMesa OUT NUMBER
) IS
BEGIN
    SELECT TC_DscMesa
    INTO p_DscMesa
    FROM TREST_MESAS
    WHERE TN_IdMesa = p_IdMesa;
END;
/
-------
CREATE OR REPLACE PROCEDURE Registrar_Operacion_Bitacora (
    p_TablaAfectada IN BITACORA.TablaAfectada%TYPE,
    p_Operacion IN BITACORA.Operacion%TYPE,
    p_Usuario IN BITACORA.Usuario%TYPE,
    p_ValoresAntiguos IN BITACORA.ValoresAntiguos%TYPE,
    p_ValoresNuevos IN BITACORA.ValoresNuevos%TYPE
) IS
BEGIN
    INSERT INTO BITACORA (TablaAfectada, Operacion, Usuario, ValoresAntiguos, ValoresNuevos)
    VALUES (p_TablaAfectada, p_Operacion, p_Usuario, p_ValoresAntiguos, p_ValoresNuevos);
END;
/



