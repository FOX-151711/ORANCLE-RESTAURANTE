--Triggers
---- Genera una bitácora cada vez que el cliente realice una reserva 

CREATE OR REPLACE TRIGGER TRG_INS_Reservacion
AFTER INSERT ON tabla_menu
FOR EACH ROW
BEGIN
    INSERT INTO bitacora_reservaciones (
        id_cliente,
        id_item_menu,
        cantidad,
        fecha_pedido
    ) VALUES (
        :NEW.id_cliente,
        :NEW.id_item_menu,
        :NEW.cantidad,
        SYSDATE
    );
END;
------- Lo que hace es que la tabla comienze en 1 y ahi se vayan aumentando 
CREATE SEQUENCE seq_bitacora_Reservaciones
START WITH 1
INCREMENT BY 1;
----Si el cliente ya tiene una reservacion se va a disparar el Triggers  y si no se agregara 
CREATE OR REPLACE TRIGGER TR_Cliente
BEFORE INSERT ON cliente
FOR EACH ROW
DECLARE
    v_reservacion_existente NUMBER;
BEGIN
   
    SELECT COUNT(*)
    INTO v_reservacion_existente
    FROM reservaciones
    WHERE id_cliente = :NEW.id_cliente;

    IF v_reservacion_existente > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'El cliente con ID ' || :NEW.id_cliente || ' ya tiene una reservación existente.');
    END IF;
END;

-------El trigger se disparara cuando se intente insertar un nuevo cliente y ya no haya espacio disponible en las mesas y se les dara un aviso 
CREATE OR REPLACE TRIGGER TR_Espacios_Mesas
BEFORE INSERT ON cliente
FOR EACH ROW
DECLARE
    v_mesas_ocupadas NUMBER;
    v_total_mesas NUMBER;
    v_mensaje VARCHAR2(100) := 'No contamos con más espacio, ¡los esperamos pronto!.';
BEGIN
    
    SELECT COUNT(*)
    INTO v_mesas_ocupadas
    FROM mesas
    WHERE estado = 'OCUPADO';

   
    SELECT COUNT(*)
    INTO v_total_mesas
    FROM mesas;


    IF v_mesas_ocupadas >= v_total_mesas THEN
        
        RAISE_APPLICATION_ERROR(-20002, v_mensaje);
    END IF;
END;



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
