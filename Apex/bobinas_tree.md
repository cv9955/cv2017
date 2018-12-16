# Bobinas Apex

## MenuBar
- Bobinas > P300
  - Listado > P304
    - Usadas  > P331
  - Corrugado > P303
  - Compras  > P310
    - Mensual > P332
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
SELECT ID,TIPO,
	FORMATO,GRAMAJE,PESO,PSTOCK,
    DIAMETRO_ACTUAL DIAMETRO,
    METROS_ACTUAL METROS 
	FROM V0_BOB
WHERE STATUS IN (1,2) 
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
> [bobinas_corrugado.js](/js/bobinas_corrugado.js)

### Dynamic Actions
```SQL 
// P303_ID_TO_DELETE 
DELETE FROM BOB_USO WHERE ID = :P303_ID_TO_DELETE;

// P303_ID_A_SUBIR
BOB_PKG.SUBIRORDENUSO(:P303_ID_A_SUBIR);

// P303_ID_A_BAJAR
BOB_PKG.BAJARORDENUSO(:P303_ID_A_BAJAR);

// P303_ORDEN_A_SUBIR
PROD_PKG.SUBIR_ORDEN_CORRUGADO(:P303_ORDEN_A_SUBIR);

// P303_ORDEN_A_BAJAR
PROD_PKG.BAJAR_ORDEN_CORRUGADO(:P303_ORDEN_A_BAJAR);

// P303_ORDEN_A_BORRAR
PROD_PKG.BORRAR_ORDEN_CORRUGADO(:P303_ORDEN_A_BORRAR);
```

## 331 - LISTADO
> Listado Stock Completo (Enteras y puchos)


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

## 315 - IMPRIMIR Planilla
![pag315.png](/img/pag315.png)
[pag315.pdf](/pdf/pag315.pdf)

## 316 - IMPRIMIR Etiquetas
![pag316.png](/img/pag316.png)
[pag316.pdf](/pdf/pag316.pdf)

### Package BOB_PRINT
[bob_print.sql](/sql/bob_print.sql)

## 330 - RESUMEN STOCK :key: 12
> Stock Actual, Valorizado, Compras vs Corrugado

## 331 - USADAS
> Listado Bobinas Usadas (incluye anuladas)

## 332 - RESUMEN MENSUAL :key:
> Compras vs Corrugado Mensual, Grafico ultimos años
![pag332.png](/img/pag332.png)
### VIEW_BOB_MENSUAL
```SQL
CREATE OR REPLACE FORCE VIEW "VIEW_BOB_MENSUAL" ("PERIODO", "COMPRAS", "CORRUGADO") AS 
  SELECT PERIODO, SUM(COMPRAS) COMPRAS,SUM(CORRUGADO) CORRUGADO FROM (
		SELECT TO_CHAR(O.FECHA,'YYYY/MM') PERIODO,
            SUM(BOB.PESO) COMPRAS,0 CORRUGADO
            FROM BOB_ORDEN O,BOB 
            WHERE O.ID = BOB.ORDEN_INGRESO
            GROUP BY TO_CHAR(O.FECHA,'YYYY/MM'),0
		UNION ALL
        SELECT TO_CHAR(U.FECHA,'YYYY/MM') PERIODO,0 COMPRAS,
            ROUND(SUM(BOB.PESO * U.USO / 100)) CORRUGADO
            FROM BOB_USO U,BOB
            WHERE U.BOBINA = BOB.ID
            GROUP BY TO_CHAR(U.FECHA,'YYYY/MM'),0
		)
		GROUP BY PERIODO
/
```

## 333 - RESUMEN ANUAL :key: 16 17
> Resumen Anual, Compras vs Corrugado, Graficos x Tipo y Formato 

