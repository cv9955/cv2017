# Cuenta Corriente
## CABS_ENTREGAS_M
```SQL
CREATE TABLE vic.cabs_entregas_m (
    id            NUMBER NOT NULL,	-- pk
    fecha         DATE NOT NULL,
    cliente       NUMBER NOT NULL,	--> CLI
    iibb          NUMBER(*,4),		--# CLI_IIBB 
    remito        NUMBER NOT NULL,
    factura_id    NUMBER,			--> CABS_FACTURAS
    dfiscal       NUMBER,		--> CLI_DFISCAL
    deposito      NUMBER,		--> CLI_DEPOSITO
    status        NUMBER DEFAULT 1 NOT NULL, --> LOV_ESTADO_ENTREGA
    id_viaje      NUMBER,
    subt_neto     NUMBER(*,2),
    subt_iva      NUMBER(*,2),
    subt_iibb     NUMBER(*,2),
    total         NUMBER(*,2),
    notas         VARCHAR2(400 BYTE),	
    created_by    VARCHAR2(20 BYTE),
    created_fec   DATE	
)
```
### LOV_ESTADO_ENTREGA
|VALUE|DISPLAY|
|---|---|
|1|PREPARADO|
|2|EMITIDO|
|3|REVISADO|
|-1|ANULADO|

## CABS_ENTREGAS
```SQL
CREATE TABLE vic.cabs_entregas (
    id            NUMBER NOT NULL,	-- pk
    id_cab        NUMBER NOT NULL,	--> CABS_ENTREGAS_M
    art           NUMBER(*,0),		--> ART
    cant          NUMBER,
    precio        NUMBER(*,4),
    iva           NUMBER(*,4),
    detalle       VARCHAR2(40 BYTE),
    pedido        NUMBER,		--> CABS_PEDIDOS
    created_by    VARCHAR2(20 BYTE),
    created_fec   DATE	
)
```

## CABS_FACTURAS
```SQL
CREATE TABLE vic.cabs_facturas (
    id                     NUMBER(*,0) NOT NULL,
    fecha                  DATE,
    tipo_cab               NUMBER,	--> LOV_TIPO_CAB
    punto_venta            NUMBER(*,0),
    nro_cab                NUMBER(*,0),
    cuit                   VARCHAR2(11 BYTE),
    dfiscal                VARCHAR2(80 BYTE),
    total_operacion        NUMBER(*,2),
    total_no_gravado       NUMBER(*,2),
    neto_gravado           NUMBER(*,2),
    impuesto_1             NUMBER(*,2),
    impuesto_2             NUMBER(*,2),
    importe_oper_exentas   NUMBER(*,2),
    importe_percep_nac     NUMBER(*,2),
    importe_percep_iibb    NUMBER(*,2),
    importe_percep_muni    NUMBER(*,2),
    importe_imp_internos   NUMBER(*,2),
    cai                    VARCHAR2(14 BYTE)
)
```

###LOV_TIPO_CAB
|VALUE|DISPLAY|
|---|---|
|0|SALDO INICIAL|
|1|FACTURA A|
|2|NOTA DEBITO|
|3|NOTA CREDITO|
|9|RECIBO|
|19|FACT EXPO|
|101|REMITO|
|102|PAGO|



## CABS_FACTURAS_DETALLE
```SQL
CREATE TABLE vic.cabs_facturas_detalle (
    id             NUMBER NOT NULL,
    id_cab         NUMBER(*,0),	--> CABS_FACTURAS
    fecha          DATE,
    tipo_cab       NUMBER,	--> LOV_TIPO_CAB
    punto_venta    NUMBER,
    nro_cab        NUMBER,
    cantidad       NUMBER(*,2),
    unidad         VARCHAR2(2 BYTE),
    precio         NUMBER(*,2),
    bonificacion   NUMBER(*,2),
    ajuste         NUMBER(*,2),
    subtotal       NUMBER(*,2),
    iva            NUMBER(*,2),
    modo           VARCHAR2(1 BYTE),
    anulado        VARCHAR2(1 BYTE),
    texto          VARCHAR2(75 BYTE)
)
```

## CABS_RECIBOS 
```SQL
CREATE TABLE vic.cabs_recibos (
    id                NUMBER(*,0) NOT NULL, --pk
    fecha             DATE,
    tipo_cab          NUMBER,	
    punto_venta       NUMBER(*,0),
    nro_cab           NUMBER(*,0),
    cuit              VARCHAR2(11 BYTE),
    dfiscal           VARCHAR2(80 BYTE),
    total_operacion   NUMBER(*,2),
    eft               NUMBER,
    retenciones       NUMBER,
    deposito          NUMBER(*,2),
    compensacion      NUMBER(*,2),
    id_razon          NUMBER,	--> CLI_DFISCAL
    obs               VARCHAR2(400 BYTE),
    cheques           NUMBER(*,2)	--# DOCS_CHEQUES
)
```

## DOCS_CHEQUES
```SQL
CREATE TABLE vic.docs_cheques (
    id            NUMBER NOT NULL,	--pk
    key           NUMBER,		--uk	
    recibo        NUMBER(*,0),		--> CABS_RECIBOS	
    id_razon      NUMBER(*,0),		--> CLI_DFISCAL	
    fecha         DATE,
    cheque        NUMBER,
    banco         VARCHAR2(20 BYTE),
    cuenta        VARCHAR2(20 BYTE),	
    cliente       VARCHAR2(80 BYTE),
    rsocial       VARCHAR2(200 BYTE),	
    importe       NUMBER(*,2),
    vencimiento   DATE
)
```  
 
## DOCS_RETEN
```SQL
CREATE TABLE vic.docs_reten (
    id         NUMBER NOT NULL,  --PK
    recibo     NUMBER,  	--> CABS_RECIBOS
    tipo_ret   NUMBER,  	--> DOCS_RETEN_TIPO
    numero     NUMBER,
    fecha      DATE,
    importe    NUMBER(*,2)
)
```  

## DOCS_RETEN_TIPO
```SQL
CREATE TABLE vic.docs_reten_tipo (
    id          NUMBER NOT NULL,	--pk
    codigo      VARCHAR2(10 BYTE),
    retencion   VARCHAR2(80 BYTE)
)
```
###LOV_TIPO_RETEN
|VALUE|DISPLAY|
|---|---|
|1|GANANCIAS|
|2|IVA|
|3|IIBB|
|4|PATRONALES|


## CABX_FACT_RECIBO
```SQL
 CREATE TABLE "VIC"."CABX_FACT_RECIBO" 
   (	
	"ID_FACTURA" NUMBER NOT NULL ENABLE, 
	"ID_RECIBO" NUMBER, 
	"VALOR" NUMBER(*,2)
   ) 
```



## CABX_FACT_ENTREGA

# VISTAS

## V1_RECIBOS
|ID|TIPO_CAB|FECHA|CLIENTE|NRO|TOTAL|OBS|PAGO|REMITOS|
```SQL
	SELECT ID, TIPO_CAB, 
		TO_CHAR(PUNTO_VENTA,'FM0000') || '-' || TO_CHAR(NRO_CAB,'FM00000000') NRO, 		
		FECHA, ID_RAZON , TOTAL_OPERACION TOTAL,   
		EFT, 
		(SELECT SUM(IMPORTE)FROM DOCS_CHEQUES WHERE RECIBO = R.ID)	CHEQUES,   
        RETENCIONES,
		DEPOSITO, 
		COMPENSACION,
		OBS,
		(SELECT SUM(X.VALOR) FROM cabX_fact_recibo X WHERE R.ID = x.id_RECIBO) PAGO  ,
		(SELECT LISTAGG(F.NRO_CAB,' ')within group(order by y.id_recibo) 
			FROM cabX_fact_recibo Y ,CABS_FACTURAS F
			WHERE y.id_factura = F.id and y.id_recibo = r.id) REMITOS 
	FROM CABS_RECIBOS R
```

## V1_FACTURAS
```SQL
SELECT 
	ID ,
	TIPO_CAB ,
	CASE WHEN TIPO_CAB IN (3) THEN -1 ELSE 1 END SIGNO,
	FECHA ,
	(SELECT ID FROM CLI_DFISCAL WHERE CUIT = F.CUIT) ID_RAZON,
	CUIT ,
	DFISCAL ,
	NRO_CAB NRO ,
	TOTAL_OPERACION TOTAL,
	(SELECT SUM(X.VALOR) FROM cabX_fact_recibo X WHERE F.ID = x.id_factura) PAGO,
	(SELECT LISTAGG(R.NRO,',')within group(order by y.id_factura) 
		FROM cabX_fact_recibo Y ,v1_recibos R
			WHERE y.id_recibo = r.id and y.id_factura = f.id) recibos
FROM CABS_FACTURAS F ;
```

## CTACTE
|ID|FECHA|TIPO_CAB|SIGNO|NRO_CAB|ID_RAZON|CUIT|RAZON_SOCIAL|TOTAL|

```SQL
	SELECT 
		DF.ID,
		NVL(DF.SALDO_FEC,TO_DATE('01-01-2018', 'DD-MM-YYYY')) FECHA,
		0 TIPO_CAB,
		NULL NRO_CAB,
		DF.CUIT,
		DF.RAZON_SOCIAL,
		DF.SALDO_INI TOTAL,
		1 SIGNO 
    FROM CLI_DFISCAL DF 
		WHERE NOT DF.SALDO_INI IS NULL 

	UNION ALL    

	SELECT 
		R.ID,
		R.FECHA,
		R.TIPO_CAB,
		TO_CHAR(R.PUNTO_VENTA,'FM0000')||'-'||TO_CHAR(R.NRO_CAB,'FM00000000') NRO_CAB,
		R.CUIT,
		DF.RAZON_SOCIAL,
		R.TOTAL_OPERACION,
		-1 SIGNO 
    FROM CABS_RECIBOS R LEFT JOIN CLI_DFISCAL DF ON R.CUIT = DF.CUIT 
		WHERE NOT R.CUIT IS NULL

	UNION ALL 

	SELECT 
		F.ID,
		F.FECHA,
		F.TIPO_CAB,
		TO_CHAR(F.PUNTO_VENTA,'FM0000')||'-'||TO_CHAR(F.NRO_CAB,'FM00000000') NRO_CAB,
		F.CUIT,
		DF.RAZON_SOCIAL,
		F.total_operacion ,
		CASE F.TIPO_CAB WHEN 3 THEN -1 ELSE 1 END SIGNO
    FROM CABS_FACTURAS F LEFT JOIN CLI_DFISCAL DF ON F.CUIT = DF.CUIT
```