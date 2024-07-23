--BASE DE DATOS--

-- Creación de la tabla TREST_TIPOMENU
CREATE TABLE TREST_TIPOMENU (
    TN_IdTipoMenu INT PRIMARY KEY,
    TC_DscTipoMenu VARCHAR2(100) NOT NULL
);

-- Creación de la tabla TREST_MENU
CREATE TABLE TREST_MENU (
    TN_IdMenu INT PRIMARY KEY,
    TC_DscMenu VARCHAR2(100) NOT NULL,
    TN_IdTipoMenu INT NOT NULL,
    TD_Precio DECIMAL(19, 2) NOT NULL,
    FOREIGN KEY (TN_IdTipoMenu) REFERENCES TREST_TIPOMENU(TN_IdTipoMenu)
);

-- Creación de la tabla TREST_MESAS
CREATE TABLE TREST_MESAS (
    TN_IdMesa INT PRIMARY KEY,
    TC_DscMesa VARCHAR2(100) NOT NULL
);

-- Creación de la tabla TREST_CLIENTES
CREATE TABLE TREST_CLIENTES (
    TN_IdCliente INT PRIMARY KEY,
    TC_Nombre VARCHAR2(60) NOT NULL,
    TC_Ap1 VARCHAR2(60) NOT NULL,
    TC_Ap2 VARCHAR2(60),
    TC_NumTelefono VARCHAR2(15),
    TC_CorreoElectronico VARCHAR2(100)
);

-- Creación de la tabla TREST_RESERVACION
CREATE TABLE TREST_RESERVACION (
    TN_NumReservacion INT PRIMARY KEY,
    TN_IdCliente INT NOT NULL,
    TN_IdMesa INT NOT NULL,
    TN_IdMenu INT NOT NULL,
    TN_Cantidad INT NOT NULL,
    TF_FecReserva TIMESTAMP NOT NULL,
    FOREIGN KEY (TN_IdCliente) REFERENCES TREST_CLIENTES(TN_IdCliente),
    FOREIGN KEY (TN_IdMesa) REFERENCES TREST_MESAS(TN_IdMesa),
    FOREIGN KEY (TN_IdMenu) REFERENCES TREST_MENU(TN_IdMenu)
);

-- Creación de la tabla BITACORA
CREATE TABLE BITACORA (
    IdBitacora INT PRIMARY KEY,
    TablaAfectada VARCHAR2(100),
    Operacion VARCHAR2(10),
    FechaHora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Usuario VARCHAR2(50),
    ValoresAntiguos CLOB,
    ValoresNuevos CLOB
);
