# Bobinas Apex

## MenuBar
- Bobinas > P300
  - Corrugado > P303
  - Compras  > P310
  - Stock  > P330

## 300 - BOBINAS MAIN
> Grafico de Stock
```SQL
SELECT  B.TIPO, B.FORMATO , B.KILOS ,T.TIPO_PAPEL
  FROM  ( 
    SELECT FORMATO , TIPO , SUM(PESO * PSTOCK / 100) AS KILOS 
      FROM BOB  
      WHERE ESTADO IN (1,2)
      GROUP BY FORMATO,TIPO
) B, BOB_TIPO T
  WHERE B.TIPO = T.ID
```
![pag300.png](/img/pag300.png)


## 301 - STOCK DIALOG
> Lista de Bobinas, filtrado por Tipo y Formato 
```SQL
SELECT ID, TIPO, FORMATO, GRAMAJE, PESO, PSTOCK,
    BOB_PKG.DIAMETROACTUAL(ID) AS DIAMETRO,
    ROUND(PSTOCK * PESO /FORMATO / GRAMAJE * 1000) AS METROS 
FROM BOB
	WHERE ESTADO IN (1,2) 
	AND FORMATO = :P301_FORMATO
	AND TIPO = :P301_TIPO
```
![pag301.png](/img/pag301.png)

## 302 - BOBINA POPUP
> Datos de Bobina, buscado por Id
![pag302.png](/img/pag302.png)

## 303 - BOBINAS CORRUGADO
Planilla de Corrugado, Baja de Stock
![pag303.png](/img/pag303.png)
```SQL
SELECT D.ID,D.ID_CORR,D.FORMATO,D.ORDEN,D.CALIDAD,
	PROD_PKG.MetrosCorrugado(D.ID) AS METROS , 
	'<a href=javascript:$s("P303_ORDEN_A_BORRAR",'||D.ID||') class="fa fa-trash" ></a>' as BORRAR,
	'<a href=javascript:$s("P303_ORDEN_A_SUBIR",'||D.ID||') class="fa fa-arrow-up" ></a>' ||
	'<a href=javascript:$s("P303_ORDEN_A_BAJAR",'||D.ID||') class="fa fa-arrow-down" ></a>' as link
	FROM CABS_CORR_D D
	WHERE FECHA = :P303_FECHA
	ORDER BY ORDEN;
```
![pag303_2.png](/img/pag303_2.png)
```SQL
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
``` 
### javascript
> #APP_IMAGES#bobinas_corrugado.js
[bobinas_corrugado.js](/js/bobinas_corrugado.js)

### Dynamic Actions
- P303_ID_TO_DELETE 
```SQL 
DELETE FROM BOB_USO WHERE ID = :P303_ID_TO_DELETE;
```
- P303_ID_A_SUBIR
```SQL 
BOB_PKG.SUBIRORDENUSO(:P303_ID_A_SUBIR);
```
- P303_ID_A_BAJAR
```SQL 
BOB_PKG.BAJARORDENUSO(:P303_ID_A_BAJAR);
```
- P303_ORDEN_A_SUBIR
```SQL 
PROD_PKG.SUBIR_ORDEN_CORRUGADO(:P303_ORDEN_A_SUBIR);
```
- P303_ORDEN_A_BAJAR
```SQL 
PROD_PKG.BAJAR_ORDEN_CORRUGADO(:P303_ORDEN_A_BAJAR);
```
- P303_ORDEN_A_BORRAR
```SQL 
PROD_PKG.BORRAR_ORDEN_CORRUGADO(:P303_ORDEN_A_BORRAR);
```

## 310 - BOBINAS COMPRAS
> Ultimos Ingresos, estadisticas de Compras
![pag310.png](/img/pag310.png)


## 311 - ALTA BOBINAS w1
> Paso 1: Provedor, Fecha, Remito
![pag311.png](/img/pag311.png)

## 312 - ALTA BOBINAS w2
> Paso 2: Tipo, Formato, Gramaje, Cantidad
![pag312.png](/img/pag312.png)

## 313 - ALTA BOBINAS w3
> Final: Genera Bobinas 
![pag313.png](/img/pag313.png)

### Generar BOBINAS
```SQL
DECLARE
	CURSOR CX IS
		SELECT n001 tipo,n002 formato,n003 gramaje ,n004 cant 
			from apex_collections 
			where collection_name = 'W1';
	item cx%ROWTYPE;
BEGIN
	INSERT INTO BOB_ORDEN (PROV,REMITO,FECHA)
		VALUES (:P311_PROVEEDOR,:P311_REMITO,:P311_FECHA)
		RETURNING ID into :P313_ORDEN;

	OPEN CX;
	LOOP FETCH CX into item;
		EXIT WHEN CX%NOTFOUND;

		FOR I IN 1..item.cant LOOP
			INSERT INTO BOB(TIPO,FORMATO,GRAMAJE,ORDEN_INGRESO)
				VALUES(item.tipo,item.formato,item.gramaje,:P313_ORDEN);
		END LOOP;	 

	END LOOP;
	CLOSE CX;
END;   
```

## 314 - BOBINAS Ingreso
> Planilla Ingreso Imprime Planilla, Etiquetas
![pag314.png](/img/pag314.png)

## 315 - IMPRIMIR Planilla 40
![pag315.pdf](/pdf/pag315.png)

## 316 - IMPRIMIR Etiquetas 41
![pag316.pdf](/pdf/pag316.png)

### Package BOB_PRINT
[bob_print.sql](/sql/bob_print.sql)

## 330 - RESUMEN STOCK :key: 1
> Stock Actual, Valorizado, Compras vs Corrugado

## 331 - LISTADO COMPLETO :key: 10
> Listado Completo, incluye usadas y anuladas

## 332 - RESUMEN MENSUAL :key: 4
> Compras vs Corrugado Mensual, Grafico ultimos años

## 333 - RESUMEN ANUAL :key: 16 17
> Resumen Anual, Compras vs Corrugado, Graficos x Tipo y Formato 