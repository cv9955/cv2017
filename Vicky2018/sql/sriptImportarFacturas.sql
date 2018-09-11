INSERT INTO CABS_FACTURAS
	(FECHA,TIPO_CAB,PUNTO_VENTA,NRO_CAB,CUIT,DFISCAL,
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
SELECT
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
FROM import_cabecera
WHERE tipo_registro = 1;

/


INSERT INTO CABS_FACTURAS_DETALLE
	(FECHA,TIPO_CAB,PUNTO_VENTA,NRO_CAB,CANTIDAD,UNIDAD,PRECIO,BONIFICACION,AJUSTE,SUBTOTAL,IVA,MODO,ANULADO,TEXTO,ID_CAB)
SELECT 
	to_date(FECHA_COMPROBANTE,'YYYYMMDD'),
	TIPO_COMPROBANTE,
	F.PUNTO_VENTA,
	NRO_COMPROBANTE,
	CANTIDAD/ 100000,
	UNIDAD_MEDIDA,
	PRECIO_UNITARIO/ 1000,
	IMPORTE_BONIFICACION/ 100,
	IMPORTE_AJUSTE/ 100,
	SUBTOTAL/ 1000,
	ALICUOTA_IVA / 100,
	MODO,
	ANULADO,
	TEXTO,
	F.ID
FROM IMPORT_DETALLE D,CABS_FACTURAS F
	WHERE D.TIPO_COMPROBANTE = F.TIPO_CAB
	AND D.PUNTO_VENTA = F.PUNTO_VENTA
	AND D.NRO_COMPROBANTE = F.NRO_CAB;
/