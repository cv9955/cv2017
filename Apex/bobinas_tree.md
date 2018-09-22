# Bobinas Apex

## MenuBar
- Bobinas > P300
  - Corrugado > P303
  - Compras  > P310
  - Stock  > P330

## 300 - BOBINAS MAIN
> Grafico de Stock
'''SQL
SELECT  B.TIPO, B.FORMATO , B.KILOS ,T.TIPO_PAPEL
  FROM  ( 
    SELECT FORMATO , TIPO , SUM(PESO * PSTOCK / 100) AS KILOS 
      FROM BOB  
      WHERE ESTADO IN (1,2)
      GROUP BY FORMATO,TIPO
) B, BOB_TIPO T
  WHERE B.TIPO = T.ID
'''
![pag300.png](/img/pag300.png)


## 301 - STOCK DIALOG
> Lista de Bobinas, filtrado por Tipo y Formato 
'''SQL
SELECT ID, TIPO, FORMATO, GRAMAJE, PESO, PSTOCK,
    BOB_PKG.DIAMETROACTUAL(ID) AS DIAMETRO,
    ROUND(PSTOCK * PESO /FORMATO / GRAMAJE * 1000) AS METROS 
FROM BOB
	WHERE ESTADO IN (1,2) 
	AND FORMATO = :P301_FORMATO
	AND TIPO = :P301_TIPO
'''
![pag301.png](/img/pag301.png)

## 302 - BOBINA POPUP
> Datos de Bobina, buscado por Id
![pag302.png](/img/pag302.png)

## 303 - BOBINAS CORRUGADO 21 *
Planilla de Corrugado, Baja de Stock
![pag303.png](/img/pag303.png)
'''SQL
SELECT D.ID,D.ID_CORR,D.FORMATO,D.ORDEN,D.CALIDAD,
	PROD_PKG.MetrosCorrugado(D.ID) AS METROS , 
	'<a href=javascript:$s("P303_ORDEN_A_BORRAR",'||D.ID||') class="fa fa-trash" ></a>' as BORRAR,
	'<a href=javascript:$s("P303_ORDEN_A_SUBIR",'||D.ID||') class="fa fa-arrow-up" ></a>' ||
	'<a href=javascript:$s("P303_ORDEN_A_BAJAR",'||D.ID||') class="fa fa-arrow-down" ></a>' as link
	FROM CABS_CORR_D D
	WHERE FECHA = :P303_FECHA
	ORDER BY ORDEN;
'''

'''SQL
SELECT U.ID, U.ORDEN, U.BOBINA,	B.TIPO, B.FORMATO, B.GRAMAJE,
	BOB_PKG.SDIAMETROS (U.ID) DIAMETRO ,
	BOB_PKG.METROSUSO  (U.ID) METROS ,
	'<a href=javascript:$s("P303_ID_TO_DELETE",'||BOB_USO.ID||') class="fa fa-trash" ></a>' delete_link,
	'<a href=javascript:$s("P303_ID_A_SUBIR",'||BOB_USO.ID||') class="fa fa-arrow-up" ></a>' ||
	'<a href=javascript:$s("P303_ID_A_BAJAR",'||BOB_USO.ID||') class="fa fa-arrow-down" ></a>' as link
	FROM BOB_USO U,BOB B
	WHERE U.FECHA = :P303_FECHA 
	AND U.LUGAR = 1
	AND U.BOBINA = B.ID
	ORDER BY U.ORDEN
''' 
### javascript
> #APP_IMAGES#bobinas_corrugado.js
[js/bobinas_corrugado.js](/js/bobinas_corrugado.js)


## 310 - BOBINAS COMPRAS 11
> Ultimos Ingresos, estadisticas de Compras

## 311 - ALTA BOBINAS w1 30
> Paso 1: Provedor, Fecha, Remito

## 312 - ALTA BOBINAS w2 32
> Paso 2: Tipo, Formato, Gramaje, Cantidad

## 313 - ALTA BOBINAS w3 34
> Final: Genera Bobinas 

## 314 - BOBINAS Ingreso 14
> Planilla Ingreso Imprime Planilla, Etiquetas

## 315 - IMPRIMIR Planilla 40

## 316 - IMPRIMIR Etiquetas 41

## 330 - RESUMEN STOCK :key: 1
> Stock Actual, Valorizado, Compras vs Corrugado

## 331 - LISTADO COMPLETO :key: 10
> Listado Completo, incluye usadas y anuladas

## 332 - RESUMEN MENSUAL :key: 4
> Compras vs Corrugado Mensual, Grafico ultimos años

## 333 - RESUMEN ANUAL :key: 16 17
> Resumen Anual, Compras vs Corrugado, Graficos x Tipo y Formato 