CREATE TABLE  "BOB_ESTADO" 
   (	"ID" NUMBER NOT NULL ENABLE, 
	"ESTADO" VARCHAR2(20), 
	 CONSTRAINT "BOB_ESTADO_PK" PRIMARY KEY ("ID") ENABLE
   )
/
CREATE TABLE  "BOB_LUGAR" 
   (	"ID" NUMBER NOT NULL ENABLE, 
	"LUGAR" VARCHAR2(20), 
	"KEY" VARCHAR2(1), 
	 CONSTRAINT "BOB_LUGAR_PK" PRIMARY KEY ("ID") ENABLE
   )
/
CREATE TABLE  "BOB_TIPO" 
   (	"ID" NUMBER NOT NULL ENABLE, 
	"KEY" CHAR(1) NOT NULL ENABLE, 
	"TIPO_PAPEL" VARCHAR2(20) NOT NULL ENABLE, 
	"BACK_COLOR" NUMBER, 
	"FORE_COLOR" NUMBER, 
	"GRAMAJE_INI" NUMBER, 
	"STYLE" VARCHAR2(20), 
	"PRECIO_ACTUAL" NUMBER, 
	 CONSTRAINT "BOB_TIPO_PK" PRIMARY KEY ("ID") ENABLE
   )
/
CREATE TABLE  "BOB_PROV" 
   (	"ID" NUMBER NOT NULL ENABLE, 
	"PROV" VARCHAR2(30) NOT NULL ENABLE, 
	"CREATED_BY" VARCHAR2(20), 
	"CREATED_FEC" DATE, 
	"UPDATED_BY" VARCHAR2(20), 
	"UPDATED_FEC" DATE, 
	"ACTIVO" VARCHAR2(1), 
	"DIAMETRO" NUMBER, 
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
CREATE TABLE  "BOB" 
   (	"ID" NUMBER NOT NULL ENABLE, 
	"TIPO" NUMBER NOT NULL ENABLE, 
	"FORMATO" NUMBER NOT NULL ENABLE, 
	"GRAMAJE" NUMBER NOT NULL ENABLE, 
	"PESO" NUMBER NOT NULL ENABLE, 
	"DIAMETRO" NUMBER, 
	"PSTOCK" NUMBER DEFAULT 100 NOT NULL ENABLE, 
	"ESTADO" NUMBER, 
	"CREATED_BY" VARCHAR2(20), 
	"CREATED_FEC" DATE, 
	"UPDATED_BY" VARCHAR2(20), 
	"UPDATED_FEC" DATE, 
	"ORDEN_INGRESO" NUMBER NOT NULL ENABLE, 
	 CONSTRAINT "BOB_PK" PRIMARY KEY ("ID") ENABLE
   )
/
CREATE TABLE  "BOB_USO" 
   (	"ID" NUMBER NOT NULL ENABLE, 
	"FECHA" DATE, 
	"LUGAR" NUMBER, 
	"ORDEN" NUMBER, 
	"BOBINA" NUMBER, 
	"INICIO" NUMBER, 
	"FIN" NUMBER, 
	"USO" NUMBER, 
	"REND" NUMBER, 
	"CREATED_BY" VARCHAR2(20), 
	"CREATED_FEC" DATE, 
	 CONSTRAINT "BOB_USO_PK" PRIMARY KEY ("ID") ENABLE
   )
/
ALTER TABLE  "BOB" ADD CONSTRAINT "BOB_ESTADO_FK" FOREIGN KEY ("ESTADO")
	  REFERENCES  "BOB_ESTADO" ("ID") ENABLE
/
ALTER TABLE  "BOB" ADD CONSTRAINT "BOB_ORDEN_FK" FOREIGN KEY ("ORDEN_INGRESO")
	  REFERENCES  "BOB_ORDEN" ("ID") ENABLE
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

insert into bob_lugar (id,lugar,key) values (1,'INTERIOR','A');
insert into bob_lugar (id,lugar,key) values (2,'ONDA','B');
insert into bob_lugar (id,lugar,key) values (3,'LINNER','C');

insert into bob_tipo (id,key,tipo_papel) values (0,'C','COMUN');
insert into bob_tipo (id,key,tipo_papel) values (1,'O','ONDA');
insert into bob_tipo (id,key,tipo_papel) values (2,'L','LINNER');
insert into bob_tipo (id,key,tipo_papel) values (3,'M','MISIONERO');
insert into bob_tipo (id,key,tipo_papel) values (4,'B','BLANCO');

insert into bob_estado (id,estado) values (0,'NUEVA');
insert into bob_estado (id,estado) values (2,'ENTERA');
insert into bob_estado (id,estado) values (3,'PUCHO');
insert into bob_estado (id,estado) values (-1,'ANULADA');
insert into bob_estado (id,estado) values (-2,'DEVOLUCION');

insert into bob_prov (id,prov) values (1,'Papelera 1');

insert into bob_orden (id,prov,remito,fecha) values (1,1,1,to_date('01/01/2001','DD/MM/YYYY'));

insert into bob (id,tipo,formato,gramaje,peso,diametro,pstock,estado,orden_ingreso)
	values (1000,1,110,130,1000,120,100,1,1);
 
/

create or replace TRIGGER BOB_ORDEN_TRG 
BEFORE INSERT ON BOB_ORDEN 
FOR EACH ROW 
DECLARE
  v_username varchar2(20);
BEGIN
  :new.created_fec := sysdate;
  :new.created_by := nvl(v('APP_USER'),USER);
END;

/

-- BRANCH BOB001-borrar seq bob prov
CREATE OR REPLACE TRIGGER BOB_PROV_TRG 
BEFORE INSERT ON BOB_PROV 
FOR EACH ROW 
BEGIN
    IF INSERTING AND :NEW.ID IS NULL THEN
      SELECT MAX(ID) +1 INTO :NEW.ID FROM BOB_PROV;
    END IF;
      :NEW.CREATED_FEC := SYSDATE;
      :NEW.CREATED_BY := NVL(V('APP_USER'),USER);
END;

/

create or replace TRIGGER BOB_TRG_000 
BEFORE INSERT ON BOB 
FOR EACH ROW 
DECLARE
  v_username varchar2(20);
BEGIN
		
		-- tipo comun = 0  onda= 1 segun gramaje
	if :new.tipo in (0,1) then
		if :new.gramaje < 140 then
			:new.tipo := 0;
		else
			:new.tipo := 1;
		end if;	
	end if;	

  :new.created_fec := sysdate;
  :new.created_by := nvl(v('APP_USER'),USER);
END;
/
create or replace TRIGGER BOB_TRG_CONTROL_ESTADO_2 
BEFORE UPDATE OF PESO ON BOB 
FOR EACH ROW 
BEGIN
  IF :NEW.ESTADO = 0 THEN
      :NEW.ESTADO := 1;
  END IF;    
END;

/

create or replace TRIGGER BOB_TRG_USOBOBINA AFTER
  UPDATE OR INSERT OR
  DELETE ON BOB_USO FOR EACH ROW 
  DECLARE 
  vBobina BOB.ID%TYPE;
  vPstock BOB.PSTOCK%TYPE;
  vEstado BOB.ESTADO%TYPE;
  BEGIN
    
    IF UPDATING THEN
      if :new.BOBINA <> :old.BOBINA then
         Raise_Application_Error(-20099, 'No se Puede Modificar Nro de Bobina en Uso.');
      end if;
    END IF;
  
    IF INSERTING OR UPDATING THEN
      vBobina := :new.BOBINA;
    ELSE
      vBobina := :old.BOBINA;
    END IF;
    
    SELECT PSTOCK,ESTADO INTO vPstock,vEstado 
    FROM BOB WHERE ID = vBobina;
    
    IF DELETING or UPDATING THEN 
      if :old.USO > (100 - vPstock) then
        vPstock := 100 ; -- el uso eliminado estaba mal cargado   
      else
        vPstock :=  vPstock + :old.USO;
      end if;
    END IF;    
    
    IF INSERTING or UPDATING THEN
      if :new.uso > vPstock then
        vPstock := 0; -- el Puso es mayor que el stock actual
        Raise_Application_Error(-20099, '%USO es mayor que el Stock Actual.');
      else
        vPstock := GREATEST (vPstock - :new.USO,0);
      end if;
    END IF;

    IF vEstado >= 0 THEN
      vEstado  :=
      CASE vPstock
      WHEN 100 THEN        1
      WHEN 0 THEN        3
      ELSE        2
      END;
    END IF;
    
    UPDATE BOB 
    SET PSTOCK = vPSTOCK ,
    ESTADO = vEstado
    WHERE ID = vBobina;
    
  END;
/
  
CREATE OR REPLACE TRIGGER BOB_USO_TRG 
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
    IF :NEW.FIN > 20 THEN 
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
