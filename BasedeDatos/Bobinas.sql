CREATE TABLE  "BOB_ESTADO" 
   (	"ID" NUMBER NOT NULL ENABLE, 
	"ESTADO" VARCHAR2(20), 
	 CONSTRAINT "BOB_ESTADO_PK" PRIMARY KEY ("ID") ENABLE
   )
/
CREATE TABLE  "BOB_PROV" 
   (	"ID" NUMBER NOT NULL ENABLE, 
	"PROV" VARCHAR2(30) NOT NULL ENABLE, 
	"CREATED_BY" VARCHAR2(20), 
	"CREATED_FEC" DATE, 
	"ACTIVO" VARCHAR2(1), 
	 CONSTRAINT "BOB_PROV_PK" PRIMARY KEY ("ID") ENABLE
   )
/
CREATE TABLE  "BOB_ORDEN" 
   (	"ID" NUMBER NOT NULL ENABLE, 
	"PROV" NUMBER, 
	"REMITO" NUMBER, 
	"FECHA" DATE, 
	"CREATED_BY" VARCHAR2(20), 
	"CREATED_FEC" DATE, 
	 CONSTRAINT "BOB_ORDEN_PK" PRIMARY KEY ("ID") ENABLE
   )
/
CREATE TABLE  "BOB_TIPO" 
   (	"ID" NUMBER NOT NULL ENABLE, 
	"KEY" CHAR(1) NOT NULL ENABLE, 
	"TIPO_PAPEL" VARCHAR2(20) NOT NULL ENABLE, 
	 CONSTRAINT "BOB_TIPO_PK" PRIMARY KEY ("ID") ENABLE
   )
/
CREATE TABLE  "BOB" 
   (	"ID" NUMBER NOT NULL ENABLE, 
	"TIPO" NUMBER NOT NULL ENABLE, 
	"FORMATO" NUMBER NOT NULL ENABLE, 
	"GRAMAJE" NUMBER NOT NULL ENABLE, 
	"PESO" NUMBER, 
	"DIAMETRO" NUMBER, 
	"PSTOCK" NUMBER DEFAULT 100 NOT NULL ENABLE, 
	"ESTADO" NUMBER, 
	"CREATED_BY" VARCHAR2(20), 
	"CREATED_FEC" DATE, 
	"ORDEN_INGRESO" NUMBER, 
	 CONSTRAINT "BOB_PK" PRIMARY KEY ("ID") ENABLE
   )
/
CREATE TABLE  "BOB_LUGAR" 
   (	"ID" NUMBER NOT NULL ENABLE, 
	"LUGAR" VARCHAR2(20), 
	"KEY" VARCHAR2(1), 
	 CONSTRAINT "BOB_LUGAR_PK" PRIMARY KEY ("ID") ENABLE
   )
/
CREATE TABLE  "BOB_USO" 
   (	"ID" NUMBER NOT NULL ENABLE, 
	"FECHA" DATE NOT NULL ENABLE, 
	"LUGAR" NUMBER NOT NULL ENABLE, 
	"ORDEN" NUMBER NOT NULL ENABLE, 
	"BOBINA" NUMBER NOT NULL ENABLE, 
	"INICIO" NUMBER, 
	"FIN" NUMBER, 
	"USO" NUMBER NOT NULL ENABLE, 
	"REND" NUMBER, 
	"CREATED_BY" VARCHAR2(20), 
	"CREATED_FEC" DATE, 
	 CONSTRAINT "BOB_USO_PK" PRIMARY KEY ("ID") ENABLE, 
	 CONSTRAINT "CHK_BOB_USO" CHECK (USO BETWEEN 0 AND 100) ENABLE, 
	 CONSTRAINT "CHK_BOB_USO_DIAM" CHECK (INICIO > FIN) ENABLE
   )
/
ALTER TABLE  "BOB" ADD CONSTRAINT "BOB_ESTADO_FK" FOREIGN KEY ("ESTADO")
	  REFERENCES  "BOB_ESTADO" ("ID") ENABLE
/
ALTER TABLE  "BOB" ADD CONSTRAINT "BOB_ORDEN_FK" FOREIGN KEY ("ORDEN_INGRESO")
	  REFERENCES  "BOB_ORDEN" ("ID") ON DELETE CASCADE ENABLE
/
ALTER TABLE  "BOB_ORDEN" ADD CONSTRAINT "BOB_PROV_FK" FOREIGN KEY ("PROV")
	  REFERENCES  "BOB_PROV" ("ID") ENABLE
/
ALTER TABLE  "BOB" ADD CONSTRAINT "BOB_TIPO_FK" FOREIGN KEY ("TIPO")
	  REFERENCES  "BOB_TIPO" ("ID") ENABLE
/
ALTER TABLE  "BOB_USO" ADD CONSTRAINT "BOB_USO_FK" FOREIGN KEY ("BOBINA")
	  REFERENCES  "BOB" ("ID") ENABLE
/
ALTER TABLE  "BOB_USO" ADD CONSTRAINT "BOB_USO_LUGAR_FK" FOREIGN KEY ("LUGAR")
	  REFERENCES  "BOB_LUGAR" ("ID") ENABLE
/
Rem No function found to generate DDL.
CREATE UNIQUE INDEX  "BOB_USO_IX" ON  "BOB_USO" ("FECHA", "LUGAR", "ORDEN")
/

<<<<<<< HEAD
insert into bob_lugar (id,key,lugar) values (1,'A','INTERIOR');
insert into bob_lugar (id,key,lugar) values (2,'B','ONDA');
insert into bob_lugar (id,key,lugar) values (3,'C','LINNER');

insert into bob_tipo (id,key,tipo_papel) values (0,'C','COMUN');
insert into bob_tipo (id,key,tipo_papel) values (1,'O','ONDA');
insert into bob_tipo (id,key,tipo_papel) values (2,'L','LINNER');
insert into bob_tipo (id,key,tipo_papel) values (3,'M','MISIONERO');
insert into bob_tipo (id,key,tipo_papel) values (4,'B','BLANCO');

insert into bob_estado (id,estado) values (0,'NUEVA');
insert into bob_estado (id,estado) values (1,'ENTERA');
insert into bob_estado (id,estado) values (2,'PUCHO');
insert into bob_estado (id,estado) values (3,'USADA');
insert into bob_estado (id,estado) values (-1,'ANULADA');
insert into bob_estado (id,estado) values (-2,'DEVOLUCION');
=======
Rem No procedure found to generate DDL.
CREATE OR REPLACE TRIGGER  "BOB_USO_TRG" 
BEFORE INSERT ON BOB_USO 
FOR EACH ROW 
BEGIN
    -- KEY
    SELECT BOB_USO_SEQ.NEXTVAL INTO :NEW.ID FROM SYS.DUAL;
>>>>>>> e34ea12c4994d449514d9c76dea291d1e90fc4b3

    :new.created_fec := sysdate;
    :new.created_by := nvl(v('APP_USER'),USER);
    
    -- ORDEN
    SELECT NVL(MAX(ORDEN)+1,0) INTO :NEW.ORDEN 
        FROM BOB_USO 
        WHERE FECHA = :NEW.FECHA 
        AND LUGAR = :NEW.LUGAR;

    -- DIAMETRO INICIAL
	UPDATE BOB
		SET DIAMETRO = :NEW.INICIO
		WHERE ID = :NEW.BOBINA
		AND PSTOCK = 100;
        
    -- DIAMETRO FINAL
    IF :NEW.FIN < 20 THEN 
        :NEW.FIN := 0;
    END IF;

    -- RENDIMIENTO ONDA
    IF :NEW.LUGAR = 2 THEN
        :NEW.REND := 1.35;
    ELSE
        :NEW.REND := 1;
    END IF;
    
    -- CALCULO USO
    SELECT 
        PSTOCK - POWER(:NEW.FIN / DIAMETRO,2)*100 
        INTO :NEW.USO
        FROM BOB WHERE ID = :NEW.BOBINA;

END;
/
<<<<<<< HEAD

CREATE OR REPLACE TRIGGER BOB_ORDEN_TRG 
    BEFORE INSERT ON BOB_ORDEN 
    FOR EACH ROW 
BEGIN
    IF :NEW.ID IS NULL THEN
      SELECT MAX(ID) +1 INTO :NEW.ID FROM BOB_ORDEN;
    END IF;
    :NEW.CREATED_FEC := SYSDATE;  
    :NEW.CREATED_BY := NVL(V('APP_USER'),USER);
=======
ALTER TRIGGER  "BOB_USO_TRG" ENABLE
/
CREATE OR REPLACE TRIGGER  "BOB_TRG_USOBOBINA" AFTER
  INSERT OR DELETE ON BOB_USO FOR EACH ROW 
  BEGIN
    IF INSERTING THEN
        UPDATE BOB B1
            SET PSTOCK = B1.PSTOCK - :NEW.USO 
            WHERE ID = :NEW.BOBINA;
    ELSE
        UPDATE BOB B1
            SET PSTOCK =  B1.PSTOCK + :OLD.USO
            WHERE ID = :OLD.BOBINA;
    END IF;        
  END;
/
ALTER TRIGGER  "BOB_TRG_USOBOBINA" ENABLE
/
CREATE OR REPLACE TRIGGER  "BOB_TRG_NOUPDATE" 
BEFORE UPDATE OF FECHA,LUGAR,BOBINA,USO ON BOB_USO 
BEGIN
    Raise_Application_Error(-20099, 'Cannot UPDATE this TABLE.');
>>>>>>> e34ea12c4994d449514d9c76dea291d1e90fc4b3
END;
/
ALTER TRIGGER  "BOB_TRG_NOUPDATE" ENABLE
/
CREATE OR REPLACE TRIGGER  "BOB_TRG_ESTADO" 
	BEFORE UPDATE OF PSTOCK ON BOB 
	FOR EACH ROW
BEGIN
	IF :OLD.ESTADO IN (1,2,3) THEN
        :NEW.ESTADO := CASE :NEW.PSTOCK 
            WHEN 0 THEN 3 WHEN 100 THEN 1 ELSE 2 END;
		END IF;
END;
/
<<<<<<< HEAD
create or replace TRIGGER BOB_TRG_000 
BEFORE INSERT ON BOB 
FOR EACH ROW 
BEGIN
    --- NRO BOBINA
     IF :NEW.ID IS NULL THEN
      SELECT MAX(ID) +1 INTO :NEW.ID FROM BOB;
     END IF;  
     
	-- AUDIT
	:NEW.CREATED_FEC := SYSDATE;
	:NEW.CREATED_BY := NVL(V('APP_USER'),USER);

	-- CONTROL TIPO ONDA / COMUNN
	IF :NEW.TIPO IN (0,1) THEN
		IF :NEW.GRAMAJE < 140 THEN
			:NEW.TIPO := 0;
		ELSE
			:NEW.TIPO := 1;
		END IF;	
	END IF;	
    
    :NEW.DIAMETRO := NVL(:NEW.DIAMETRO,120);
    :NEW.PSTOCK := 100;
    :NEW.ESTADO := 0;

END;
/

create or replace TRIGGER BOB_TRG_CONTROL_ESTADO_2 
=======
ALTER TRIGGER  "BOB_TRG_ESTADO" ENABLE
/
CREATE OR REPLACE TRIGGER  "BOB_TRG_DELETE" 
	BEFORE DELETE ON BOB
	FOR EACH ROW
BEGIN
		IF :OLD.PSTOCK < 100 THEN
		  Raise_Application_Error(-20099, 'Cannot DELETE BOBINA USADA.');
		END IF;
END;
/
ALTER TRIGGER  "BOB_TRG_DELETE" ENABLE
/
CREATE OR REPLACE TRIGGER  "BOB_TRG_CONTROL_ESTADO_2" 
>>>>>>> e34ea12c4994d449514d9c76dea291d1e90fc4b3
BEFORE UPDATE OF PESO ON BOB 
FOR EACH ROW 
BEGIN
  IF :NEW.ESTADO = 0 THEN
      :NEW.ESTADO := 1;
  END IF;    
END;
/

create or replace TRIGGER BOB_TRG_DELETE 
	BEFORE DELETE ON BOB
	FOR EACH ROW
BEGIN
		IF :OLD.PSTOCK < 100 THEN
		  Raise_Application_Error(-20099, 'Cannot DELETE BOBINA USADA.');
		END IF;
END;
/

CREATE OR REPLACE TRIGGER BOB_TRG_ESTADO
	BEFORE UPDATE OF PSTOCK ON BOB 
	FOR EACH ROW
BEGIN
	IF :OLD.ESTADO IN (1,2,3) AND :NEW.ESTADO IN (1,2,3) THEN
        :NEW.ESTADO := CASE :NEW.PSTOCK 
            WHEN 0 THEN 3 WHEN 100 THEN 1 ELSE 2 END;
		END IF;
END;
/

create or replace TRIGGER BOB_TRG_NOUPDATE 
BEFORE UPDATE OF FECHA,LUGAR,BOBINA,USO ON BOB_USO 
BEGIN
    Raise_Application_Error(-20099, 'Cannot UPDATE this TABLE.');
END;
/
<<<<<<< HEAD

create or replace TRIGGER BOB_TRG_USOBOBINA AFTER
  INSERT OR DELETE ON BOB_USO FOR EACH ROW 
  BEGIN
    IF INSERTING THEN
        UPDATE BOB B1
            SET PSTOCK = B1.PSTOCK - :NEW.USO 
            WHERE ID = :NEW.BOBINA;
    ELSE
        UPDATE BOB B1
            SET PSTOCK =  B1.PSTOCK + :OLD.USO
            WHERE ID = :OLD.BOBINA;
    END IF;        
  END;
/
  
create or replace TRIGGER BOB_USO_TRG 
	BEFORE INSERT ON BOB_USO 
	FOR EACH ROW 
BEGIN
    -- KEY
    SELECT BOB_USO_SEQ.NEXTVAL INTO :NEW.ID FROM SYS.DUAL;

    :new.created_fec := sysdate;
    :new.created_by := nvl(v('APP_USER'),USER);
    
    -- ORDEN
    SELECT NVL(MAX(ORDEN)+1,0) INTO :NEW.ORDEN 
        FROM BOB_USO 
        WHERE FECHA = :NEW.FECHA 
        AND LUGAR = :NEW.LUGAR;

    -- DIAMETRO INICIAL
	UPDATE BOB
		SET DIAMETRO = :NEW.INICIO
		WHERE ID = :NEW.BOBINA
		AND PSTOCK = 100;
        
    -- DIAMETRO FINAL
    IF :NEW.FIN < 20 THEN 
        :NEW.FIN := 0;
    END IF;

    -- RENDIMIENTO ONDA
    IF :NEW.LUGAR = 2 THEN
        :NEW.REND := 1.35;
    ELSE
        :NEW.REND := 1;
    END IF;
    
    -- CALCULO USO
    SELECT 
        PSTOCK - POWER(:NEW.FIN / DIAMETRO,2)*100 
        INTO :NEW.USO
        FROM BOB WHERE ID = :NEW.BOBINA;
=======
ALTER TRIGGER  "BOB_TRG_CONTROL_ESTADO_2" ENABLE
/
CREATE OR REPLACE TRIGGER  "BOB_TRG_000" 
BEFORE INSERT ON BOB 
FOR EACH ROW 
BEGIN
    --- NRO BOBINA
     IF :NEW.ID IS NULL THEN
      SELECT MAX(ID) +1 INTO :NEW.ID FROM BOB;
     END IF;  
     
	-- AUDIT
	:NEW.CREATED_FEC := SYSDATE;
	:NEW.CREATED_BY := NVL(V('APP_USER'),USER);

	-- CONTROL TIPO ONDA / COMUNN
	IF :NEW.TIPO IN (0,1) THEN
		IF :NEW.GRAMAJE < 140 THEN
			:NEW.TIPO := 0;
		ELSE
			:NEW.TIPO := 1;
		END IF;	
	END IF;	
    
    :NEW.DIAMETRO := NVL(:NEW.DIAMETRO,120);
    :NEW.PSTOCK := 100;
    :NEW.ESTADO := 0;

END;
/
ALTER TRIGGER  "BOB_TRG_000" ENABLE
/
CREATE OR REPLACE TRIGGER  "BOB_PROV_TRG" 
	BEFORE INSERT ON BOB_PROV 
	FOR EACH ROW 
BEGIN
    IF :NEW.ID IS NULL THEN
      SELECT MAX(ID) +1 INTO :NEW.ID FROM BOB_PROV;
    END IF;
      :NEW.CREATED_FEC := SYSDATE;
      :NEW.CREATED_BY := NVL(V('APP_USER'),USER);
END;
/
ALTER TRIGGER  "BOB_PROV_TRG" ENABLE
/
CREATE OR REPLACE TRIGGER  "BOB_ORDEN_TRG" 
    BEFORE INSERT ON BOB_ORDEN 
    FOR EACH ROW 
BEGIN
    IF :NEW.ID IS NULL THEN
      SELECT MAX(ID) +1 INTO :NEW.ID FROM BOB_ORDEN;
    END IF;
    :new.created_fec := sysdate;  
    :new.created_by := nvl(v('APP_USER'),USER);
>>>>>>> e34ea12c4994d449514d9c76dea291d1e90fc4b3
END;
/
ALTER TRIGGER  "BOB_ORDEN_TRG" ENABLE
/
