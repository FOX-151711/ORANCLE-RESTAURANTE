--Procedimientos Almacenados

--Insertar un nuevo menú
CREATE OR REPLACE PROCEDURE InsertarMenu(
    p_TN_IdMenu INT,
    p_TC_DscMenu VARCHAR2,
    p_TN_IdTipoMenu INT,
    p_TD_Precio DECIMAL
) IS
BEGIN
    INSERT INTO TREST_MENU (TN_IdMenu, TC_DscMenu, TN_IdTipoMenu, TD_Precio)
    VALUES (p_TN_IdMenu, p_TC_DscMenu, p_TN_IdTipoMenu, p_TD_Precio);
END;
/
