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
	"DFISCAL" VARCHAR2(30), 
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
```


Tablas de Paso

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






IMPORT_FACTURAS.CTL

Load DATA 
truncate
INTO TABLE IMPORT_CABECERA
(
 Tipo_registro 				POSITION(01:01) CHAR,
 Fecha_comprobante 			POSITION(02:09) CHAR,
 Tipo_comprobante 			POSITION(10:11) CHAR,
 Controlador_Fiscal 		POSITION(12:12) CHAR,
 Punto_venta 				POSITION(13:16) CHAR,
 NRO_comprobante 			POSITION(17:24) CHAR,
 NRO_comprobante_registrado POSITION(25:32) CHAR,
 Cantidad_hojas 			POSITION(33:35) CHAR,
 Codigo_documento_comprador POSITION(36:37) CHAR,
 NRO_documento_comprador 	POSITION(38:48) CHAR,
 denominacion_comprador 	POSITION(49:78) CHAR,
 Importe_total_operacion 	POSITION(79:93) CHAR,
 Importe_total_no_gravado 	POSITION(94:108) CHAR,
 Importe_neto_gravado 		POSITION(109:123) CHAR,
 Impuesto_liquidado 		POSITION(124:138) CHAR,
 Impuesto_liquidado_2 		POSITION(139:153) CHAR,
 Importe_oper_exentas 		POSITION(154:168) CHAR,
 Importe_percep_nac 		POSITION(169:183) CHAR,
 Importe_percep_IIBB 		POSITION(184:198) CHAR,
 Importe_percep_Muni 		POSITION(199:213) CHAR,
 Importe_Imp_Internos 		POSITION(214:228) CHAR,
 Transporte 				POSITION(229:243) CHAR,
 Tipo_responsable 			POSITION(244:245) CHAR,
 Codigos_moneda 			POSITION(246:248) CHAR,
 Tipo_cambio 				POSITION(249:258) CHAR,
 Cantidad_alicuotas_IVA 	POSITION(259:259) CHAR,
 Codigo_operacion 			POSITION(260:260) CHAR,
 CAI 						POSITION(261:274) CHAR,
 Fecha_Vencimiento 			POSITION(275:282) CHAR,
 Fecha_Anulacion 			POSITION(283:290) CHAR
)



### Ejecucion

D:\> sqlldr userid=VIC/**** control=Cabecera.ctl data=CABECERA_YYYYMM.txt discard=impcabecera.dis bad=impcabecera.bad log=impcabecera.log 
![](https://raw.githubusercontent.com/cv9955/cv2017/img/import_facturas001.pgn)

insert into CABS_FACTURAS (FECHA,TIPO_CAB,PUNTO_VENTA,NRO_CAB,CUIT,DFISCAL,
 total_operacion ,
 total_no_gravado ,
 neto_gravado ,
 Impuesto_1 ,
 Impuesto_2 ,
 Importe_oper_exentas ,
 Importe_percep_nac ,
 Importe_percep_IIBB ,
 Importe_percep_Muni ,
 Importe_Imp_Internos ,
 CAI)
select
to_date(FECHA_COMPROBANTE,'YYYYMMDD'),
TIPO_COMPROBANTE,
PUNTO_VENTA,
NRO_COMPROBANTE,
nro_documento_comprador,
DENOMINACION_COMPRADOR,
import_cabecera.importe_total_operacion /100,
import_cabecera.importe_total_no_gravado/100,
import_cabecera.importe_neto_gravado/100,
import_cabecera.impuesto_liquidado/100,
import_cabecera.impuesto_liquidado_2/100,
import_cabecera.importe_oper_exentas/100,
import_cabecera.importe_percep_nac/100,
import_cabecera.importe_percep_iibb/100,
import_cabecera.importe_percep_muni/100,
import_cabecera.importe_imp_internos/100,
CAI
from import_cabecera
where tipo_registro = 1;



IMPORT_FACTURAS_DETALLE.CTL
Load DATA 
TRUNCATE
INTO TABLE IMPORT_DETALLE
(
    tipo_comprobante        POSITION(01:02) CHAR,    
    controlador_fiscal      POSITION(03:03) CHAR,      
    fecha_comprobante        POSITION(04:11) CHAR,     
    punto_venta                POSITION(12:15) CHAR,   
    nro_comprobante             POSITION(16:23) CHAR,
    nro_comprobante_registrado  POSITION(24:31) CHAR,
    cantidad                     POSITION(32:43) CHAR,
    unidad_medida               POSITION(44:45) CHAR, 
    precio_unitario              POSITION(46:61) CHAR,
    importe_bonificacion        POSITION(62:76) CHAR,
    importe_ajuste              POSITION(77:92) CHAR,
    subtotal                    POSITION(93:108) CHAR,
    alicuota_iva               POSITION(109:112) CHAR,  
    modo                       POSITION(113:113) CHAR, 
    anulado                    POSITION(114:114) CHAR,   
    texto    					POSITION(115:189) CHAR
)


D:\> sqlldr userid=VIC/AGOS2018 control=IMPORT_FACTURAS_DETALLE.ctl data=DETALLE_201802.txt discard=impDETALLE.dis bad=impDETALLE.bad log=impDETALLE.log 

