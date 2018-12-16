# Clientes 

## CLI
```SQL
 CREATE TABLE "CLI" 
   (	"ID" NUMBER(*,0) NOT NULL ENABLE, 
	"NOMBRE" VARCHAR2(200 BYTE) NOT NULL ENABLE, 
	"VENDEDOR" NUMBER(*,0) DEFAULT 0 NOT NULL ENABLE, 
	"ALIAS" VARCHAR2(6 BYTE),
	"TAGS" VARCHAR2(400 BYTE),	
	"ESTADO" NUMBER(*,0) DEFAULT 1 NOT NULL ENABLE, 
	"SALDO_INI" NUMBER(*,2), 
	"AJ_FLT" NUMBER DEFAULT NULL, 
	"AJ_COMISION" NUMBER DEFAULT 0, 
	"AJ_IIBB" NUMBER(*,4), 
	"AJ_COTIZ" NUMBER, 
	"CONTENT" BLOB, 
	"MIMETYPE" VARCHAR2(48 BYTE), 
	"FILENAME" VARCHAR2(400 BYTE), 
	"LASTUPDATED" DATE, 
	"CREATED_FEC" DATE NOT NULL ENABLE, 
	"CREATED_BY" VARCHAR2(200 BYTE) NOT NULL ENABLE, 
	"UPDATED_FEC" DATE, 
	"UPDATED_BY" VARCHAR2(200 BYTE), 
	"FEC_ULT_PEDIDO" DATE, 	
	"FEC_ULT_COTIZ" DATE, 
	"FEC_ULT_ENTREGA" DATE, 
	CONSTRAINT "CLI_PK" PRIMARY KEY ("ID")
 	CONSTRAINT "CLI_FK1" FOREIGN KEY ("VENDEDOR")	
		REFERENCES "CLI_VENDEDOR" ("ID") ENABLE, 
	CONSTRAINT "CLI_FK2" FOREIGN KEY ("ESTADO")		
		REFERENCES "CLI_ESTADO" ("ID") ENABLE
   ) 
```

## CLI_CONTACTO
```SQL
  CREATE TABLE "VIC"."CLI_CONTACTO" 
   (	"ID" NUMBER NOT NULL ENABLE, 
	"ID_CLIENTE" NUMBER NOT NULL ENABLE, 
	"NOMBRE" VARCHAR2(200 BYTE), 
	"APELLIDO" VARCHAR2(200 BYTE), 
	"TELEFONO" VARCHAR2(200 BYTE), 
	"MOVIL" VARCHAR2(200 BYTE), 
	"EMAIL" VARCHAR2(200 BYTE), 
	"DIRECCION" VARCHAR2(200 BYTE), 
	"CARGO" VARCHAR2(200 BYTE), 
	CONSTRAINT "CLI_CONTACTO_PK" PRIMARY KEY ("ID")
	) 
```	
	
## CLI_DEPOSITO
```SQL
  CREATE TABLE "VIC"."CLI_DEPOSITO" 
   (	"ID" NUMBER(*,0) NOT NULL ENABLE, 
	"ID_CLIENTE" NUMBER(*,0) NOT NULL ENABLE, 
	"NOMBRE" VARCHAR2(200 CHAR), 
	"DIRECCION" VARCHAR2(400 CHAR), 
	"HORARIO" VARCHAR2(200 CHAR), 
	"CONTACTO" VARCHAR2(400 CHAR), 
	"OBSERVACIONES" VARCHAR2(400 CHAR), 
	"STREET_NUMBER" VARCHAR2(20 BYTE), 
	"ROUTE" VARCHAR2(100 BYTE), 
	"LOCALITY" VARCHAR2(100 BYTE), 
	"ADMINISTRATIVE_AREA_LEVEL_1" VARCHAR2(50 BYTE), 
	"POSTAL_CODE" VARCHAR2(20 BYTE), 
	"COUNTRY" VARCHAR2(20 BYTE), 
	"LAT" VARCHAR2(50 BYTE), 
	"LNG" VARCHAR2(50 BYTE), 
	"CREATED_FEC" DATE NOT NULL ENABLE, 
	"CREATED_BY" VARCHAR2(200 BYTE) NOT NULL ENABLE, 
	CONSTRAINT "CLI_DEPOSITO_PK" PRIMARY KEY ("ID"),
	FOREIGN KEY ("ID_CLIENTE") REFERENCES "CLI" ("ID") ENABLE
```
	
## CLI_DFISCAL
```SQL
  CREATE TABLE "VIC"."CLI_DFISCAL" 
   (	"ID" NUMBER(*,0) NOT NULL ENABLE, 
	"ID_CLIENTE" NUMBER(*,0) NOT NULL ENABLE, 
	"RAZON_SOCIAL" VARCHAR2(200 CHAR), 
	"CUIT" VARCHAR2(200 CHAR), 
	"DOMICILIO" VARCHAR2(200 CHAR), 
	"CIUDAD" VARCHAR2(200 BYTE), 
	"CP" VARCHAR2(20 BYTE), 
	"PROVINCIA" VARCHAR2(200 BYTE), 
	"CREATED_FEC" DATE NOT NULL ENABLE, 
	"CREATED_BY" VARCHAR2(200 BYTE) NOT NULL ENABLE, 
	"IMP_IIBB" NUMBER, 
	"IMP_IVA" NUMBER, 
	"SALDO_INI" NUMBER, 
	"SALDO_FEC" DATE, 
	CONSTRAINT "VC_CLIENTE_D_FISCAL_PK" PRIMARY KEY ("ID"),
	CONSTRAINT "FK_CLI_DFISCAL" FOREIGN KEY ("ID_CLIENTE")	  
		REFERENCES "CLI" ("ID") ON DELETE CASCADE ENABLE
	 ) 
``` 

## CLI_ESTADO
|ID|ESTADO|
|---|---|
|0|ELIMINADO|
|1|INACTIVO|
|2|SIN REVISAR|
|3|ACTIVO|

## CLI_IIBB
```SQL
	CREATE TABLE "VIC"."CLI_IIBB" 
	(	"ID" NUMBER NOT NULL ENABLE, 
	"CUIT" VARCHAR2(20 BYTE), 
	"DESDE" DATE, 
	"HASTA" DATE, 
	"VALOR" NUMBER, 
	CONSTRAINT "CLI_IIBB_PK" PRIMARY KEY ("ID")
	) 
	CREATE UNIQUE INDEX "VIC"."CLI_IIBB_INDEX1" 
		ON "VIC"."CLI_IIBB" ("CUIT", "DESDE") ;
```	
	
## CLI_VENDEDOR
```SQL
 CREATE TABLE "VIC"."CLI_VENDEDOR" 
   (	"ID" NUMBER(*,0) NOT NULL ENABLE, 
	"NOMBRE" VARCHAR2(200 BYTE) NOT NULL ENABLE, 
	"APELLIDO" VARCHAR2(200 BYTE), 
	"TELEFONO" VARCHAR2(200 BYTE), 
	"MOVIL" VARCHAR2(200 BYTE), 
	"EMAIL" VARCHAR2(200 BYTE), 
	"DIRECCION" VARCHAR2(200 BYTE), 
	"CREATED_FEC" DATE, 
	"CREATED_BY" VARCHAR2(200 BYTE), 
	 CONSTRAINT "CLI_VENDEDOR_PK" PRIMARY KEY ("ID")
	)
```