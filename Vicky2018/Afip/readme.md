# Afip

## Padron IIBB
Instructivo para actualizar valor de retencion de IIBB desde el padron publicado por Afip Mensualmente

#### Explicacion
El momento de generar una factura de ventas, se debe calcular el valor del Impuesto IIBB multiplicando el Neto a Facturar por un valor publicado mensualmento por la Afip, para ello se debe descargar un archivo que contiene el listado completo de Numero de Cuit con su respectivo valor. se importa el listado en su totalidad en una tabla temporal (PADRON ARBA) para luego replicar a la tabla permanete CLI_IIBB solo los datos necesario segun Numero de Cuit. La tabla temporal se conserva hasta finalizado el periodo para consultar en caso de carga de clientes nuevos

## Pasos a seguir:
- descargar archivo desde http://www.afip.gov.ar/genericos/cinscripcion/archivocompleto.asp
- importar a Oracle (tabla temporal)
- copiar valores a tabla CLI_IIBB

Preparacion :
### Tabla CLI_IIBB
```
TABLA CLI_IIBB
  ID pk
  CUIT varchar(11)
  DESDE date
  HASTA date
  VALOR number
```

### Tabla temporal PADRON_ARBA
```
CREATE TABLE  "PADRON_ARBA"  (
  "TIPO" VARCHAR2(20), 
	"FECHA" VARCHAR2(20), 
	"DESDE" VARCHAR2(20), 
	"HASTA" VARCHAR2(20), 
	"CUIT" VARCHAR2(20) NOT NULL ENABLE, 
	"P1" VARCHAR2(20), 
	"P2" VARCHAR2(20), 
	"P3" VARCHAR2(20), 
	"VALOR" NUMBER, 
	"GRUPO" VARCHAR2(20), 
	 CONSTRAINT "PADRON_ARBA_PK" PRIMARY KEY ("CUIT") ENABLE
  )
/
```

### Archivo import_padron.ctl
```
Load DATA 
  truncate 
  INTO TABLE PADRON_ARBA
  FIELDS TERMINATED BY ";" 
  ( TIPO, FECHA, DESDE, HASTA, CUIT, P1, P2, P3, VALOR, GRUPO) 
```

### Ejecucion
Copiar el archivo descargado con el nombre "PadronRgsPer092018.txt" a D:
ejecutar Cmd (modo admin)
```
D:\> sqlldr control=import_padron.ctl data=PadronRgsPer092018.txt discard=datos.dis bad=datos.bad log=datos.log 
```
ejecutar sqlPlus
```
D:\>SQLPLUS 
SQL>  INSERT INTO CLI_IIBB (CUIT,DESDE,HASTA,VALOR)
      SELECT 
        T2.CUIT,
        TO_DATE(T2.DESDE,'DDMMYYYY'),
        TO_DATE(T2.HASTA,'DDMMYYYY'),
        VALOR 
      FROM PADRON_ARBA T2
      WHERE EXISTS(
        SELECT 1 
        FROM CLI_DFISCAL T1 
        WHERE T2.CUIT = REPLACE(T1.CUIT,'-','')
      );

      COMMIT:
```

