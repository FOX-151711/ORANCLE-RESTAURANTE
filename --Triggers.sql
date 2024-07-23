--Triggers

--Registrar inserciones en la tabla TREST_MENU
CREATE OR REPLACE TRIGGER trg_TREST_MENU_AfterInsert
AFTER INSERT ON TREST_MENU
FOR EACH ROW
BEGIN
    INSERT INTO BITACORA (TablaAfectada, Operacion, Usuario, ValoresNuevos)
    VALUES ('TREST_MENU', 'INSERT', USER, 'TN_IdMenu: ' || :NEW.TN_IdMenu || ', TC_DscMenu: ' || :NEW.TC_DscMenu || ', TN_IdTipoMenu: ' || :NEW.TN_IdTipoMenu || ', TD_Precio: ' || :NEW.TD_Precio);
END;
/

--Actualizar registros
CREATE OR REPLACE TRIGGER trg_TREST_MENU_AfterUpdate
AFTER UPDATE ON TREST_MENU
FOR EACH ROW
BEGIN
    INSERT INTO BITACORA (TablaAfectada, Operacion, Usuario, ValoresAntiguos, ValoresNuevos)
    VALUES ('TREST_MENU', 'UPDATE', USER, 'TN_IdMenu: ' || :OLD.TN_IdMenu || ', TC_DscMenu: ' || :OLD.TC_DscMenu || ', TN_IdTipoMenu: ' || :OLD.TN_IdTipoMenu || ', TD_Precio: ' || :OLD.TD_Precio, 'TN_IdMenu: ' || :NEW.TN_IdMenu || ', TC_DscMenu: ' || :NEW.TC_DscMenu || ', TN_IdTipoMenu: ' || :NEW.TN_IdTipoMenu || ', TD_Precio: ' || :NEW.TD_Precio);
END;
/

--Eliminar registros
CREATE OR REPLACE TRIGGER trg_TREST_MENU_AfterDelete
AFTER DELETE ON TREST_MENU
FOR EACH ROW
BEGIN
    INSERT INTO BITACORA (TablaAfectada, Operacion, Usuario, ValoresAntiguos)
    VALUES ('TREST_MENU', 'DELETE', USER, 'TN_IdMenu: ' || :OLD.TN_IdMenu || ', TC_DscMenu: ' || :OLD.TC_DscMenu || ', TN_IdTipoMenu: ' || :OLD.TN_IdTipoMenu || ', TD_Precio: ' || :OLD.TD_Precio);
END;
/
