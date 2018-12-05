CREATE OR REPLACE FORCE VIEW "V1_FACTURAS"
 ("ID", "TIPO_CAB", "SIGNO", "FECHA", "ID_RAZON", "CUIT", "DFISCAL", "NRO", "TOTAL", "PAGO", "RECIBOS", "REMITOS","REMITIDO") AS 
 
select id,tipo_cab,
case when tipo_cab =3 then -1 else 1 end signo,
fecha,
(select id from cli_dfiscal where cuit = f.cuit) id_razon,
cuit,
(select dfiscal from cli_dfiscal where cuit = f.cuit) dfiscal,
nro_cab,total_operacion,
(select sum(valor) FROM cabX_fact_recibo where id_factura = f.id) pago,
(SELECT LISTAGG(R.NRO,',')within group(order by y.id_factura)    FROM cabX_fact_recibo Y ,v1_recibos R WHERE y.id_recibo = r.id and y.id_factura = f.id) recibos,
(SELECT LISTAGG(m.remito,',')within group(order by e.id_factura) FROM cabx_fact_entrega E,cabs_entregas_m m WHERE e.id_factura = f.id and m.id=e.id_entrega) remitos,
(select sum(importe) FROM cabX_fact_entrega where id_factura = f.id) remitido
FROM CABS_FACTURAS F

