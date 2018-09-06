# Importar Facturas Emitidas

Instructivo para cargar facturas emitidas via Facturacion Electronica

#### Explicacion
Las facturas de ventas son generadas via pagina web de afip, los datos son extraidos desde la web y almacenados en la BD.

### Pasos a Seguir:
- descargar archivos CABECERA.TXT y DETALLE.TXT desde 
- importar a Oracle (tabla temporal)
- copiar valores a tabla CABS_FACTURAS y CABS_FACTURAS_DETALLE 


### Estructura BD :
    
```SQL
CREATE TABLE  "CABS_FACTURAS" 
(	"ID" NUMBER(*,0) NOT NULL ENABLE, 
	"FECHA" DATE, 
	"TIPO_CAB" NUMBER, 
	"PUNTO_VENTA" NUMBER(*,0), 
	"NRO_CAB" NUMBER(*,0), 
	"CUIT" VARCHAR2(11), 
	"DFISCAL" VARCHAR2(80), 
	"TOTAL_OPERACION" NUMBER(*,2), 
	"TOTAL_NO_GRAVADO" NUMBER(*,2), 
	"NETO_GRAVADO" NUMBER(*,2), 
	"IMPUESTO_1" NUMBER(*,2), 
	"IMPUESTO_2" NUMBER(*,2), 
	"IMPORTE_OPER_EXENTAS" NUMBER(*,2), 
	"IMPORTE_PERCEP_NAC" NUMBER(*,2), 
	"IMPORTE_PERCEP_IIBB" NUMBER(*,2), 
	"IMPORTE_PERCEP_MUNI" NUMBER(*,2), 
	"IMPORTE_IMP_INTERNOS" NUMBER(*,2), 
	"CAI" VARCHAR2(14), 
	 CONSTRAINT "CABS_FACTURAS_PK" PRIMARY KEY ("ID") ENABLE
   )
/
CREATE TABLE  "CABS_FACTURAS_DETALLE" 
(	"ID" NUMBER NOT NULL ENABLE, 
	"ID_CAB" NUMBER, 
	"FECHA" DATE, 
	"TIPO_CAB" NUMBER, 
	"PUNTO_VENTA" NUMBER, 
	"NRO_CAB" NUMBER, 
	"CANTIDAD" NUMBER(*,2), 
	"UNIDAD" VARCHAR2(2), 
	"PRECIO" NUMBER(*,2), 
	"BONIFICACION" NUMBER(*,2), 
	"AJUSTE" NUMBER(*,2), 
	"SUBTOTAL" NUMBER(*,2), 
	"IVA" NUMBER(*,2), 
	"MODO" VARCHAR2(1), 
	"ANULADO" VARCHAR2(1), 
	"TEXTO" VARCHAR2(80), 
	 CONSTRAINT "CABS_FACTURAS_DETA_ID_PK" PRIMARY KEY ("ID") ENABLE
   )
```


## Tablas Temporales

```SQL
CREATE TABLE "VIC"."IMPORT_CABECERA" 
(
	 Tipo_registro NUMBER,
	 Fecha_comprobante VARCHAR2(8 BYTE),
	 Tipo_comprobante VARCHAR2(2 BYTE),
	 Controlador_Fiscal VARCHAR2(1 BYTE),
	 Punto_venta VARCHAR2(4 BYTE),
	 NRO_comprobante VARCHAR2(8 BYTE),
	 NRO_comprobante_registrado VARCHAR2(8 BYTE),
	 Cantidad_hojas VARCHAR2(3 BYTE),
	 Codigo_documento_comprador VARCHAR2(2 BYTE),
	 NRO_documento_comprador VARCHAR2(11 BYTE),
	 denominacion_comprador VARCHAR2(30 BYTE),
	 Importe_total_operacion VARCHAR2(15 BYTE),
	 Importe_total_no_gravado VARCHAR2(15 BYTE),
	 Importe_neto_gravado VARCHAR2(15 BYTE),
	 Impuesto_liquidado VARCHAR2(15 BYTE),
	 Impuesto_liquidado_2 VARCHAR2(15 BYTE),
	 Importe_oper_exentas VARCHAR2(15 BYTE),
	 Importe_percep_nac VARCHAR2(15 BYTE),
	 Importe_percep_IIBB VARCHAR2(15 BYTE),
	 Importe_percep_Muni VARCHAR2(15 BYTE),
	 Importe_Imp_Internos VARCHAR2(15 BYTE),
	 Transporte VARCHAR2(15 BYTE),
	 Tipo_responsable VARCHAR2(2 BYTE),
	 Codigos_moneda VARCHAR2(3 BYTE),
	 Tipo_cambio VARCHAR2(10 BYTE),
	 Cantidad_alicuotas_IVA VARCHAR2(1 BYTE),
	 Codigo_operacion VARCHAR2(1 BYTE),
	 CAI VARCHAR2(14 BYTE),
	 Fecha_Vencimiento VARCHAR2(8 BYTE),
	 Fecha_Anulacion VARCHAR2(8 BYTE)
);
```



## Archivos sqlldr

- archivo para importar CABECERA[Cabecera.md](Cabecera.md)
- archivo para importar DETALLE[Detalle.md](Detalle.md)

## script para procesar informacion
[afip_import_facturas.sql](afip_import_facturas.sql)


### Ejecucion
```
D:\> sqlldr userid=VIC/xxxx control=Cabecera.ctl data=CABECERA_YYYYMM.txt discard=impcabecera.dis bad=impcabecera.bad log=impcabecera.log 
D:\> sqlldr userid=VIC/xxxx control=Detalle.ctl data=Detalle_YYYYMM.txt discard=impdetalle.dis bad=impdetalle.bad log=impdetalle.log
```
![sqlrd](/img/import_facturas001.png)




