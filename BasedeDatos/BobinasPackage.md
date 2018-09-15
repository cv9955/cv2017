# BOB_PKG  
     
## SubirOrdenUso (p_idUso)
```SQL
SELECT ID_1,ORDEN_1,ORDEN_2 
	INTO VID1,VORDEN1,VORDEN2
	FROM (
		SELECT B1.ID ID_1,B1.ORDEN ORDEN_1,B2.ORDEN ORDEN_2 
			FROM BOB_USO B1, BOB_USO B2
			WHERE B1.FECHA = B2.FECHA
			AND B1.LUGAR = B2.LUGAR
			AND B1.ORDEN < B2.ORDEN
			AND B2.ID = p_idUso
			ORDER BY B1.ORDEN DESC)
	WHERE ROWNUM = 1;

UPDATE BOB_USO
	SET ORDEN = CASE WHEN ID = VID1 THEN VORDEN2
	WHEN ID = p_iduso THEN VORDEN1 END
	where id in (p_iduso,VID1);     

EXCEPTION WHEN NO_DATA_FOUND THEN
	RAISE_APPLICATION_ERROR(-20001,'no puede SUBIR mas');
```
   
## BajarOrdenUso (p_idUso)
```SQL
SELECT ID_1,ORDEN_1,ORDEN_2 
	INTO VID1,VORDEN1,VORDEN2
	FROM (
	SELECT B1.ID ID_1,B1.ORDEN ORDEN_1,B2.ORDEN ORDEN_2 
		FROM BOB_USO B1, BOB_USO B2
		WHERE B1.FECHA = B2.FECHA
		AND B1.LUGAR = B2.LUGAR
		AND B1.ORDEN > B2.ORDEN
		AND B2.ID = p_idUso
		ORDER BY B1.ORDEN ASC)
	WHERE ROWNUM = 1;

UPDATE BOB_USO
	SET ORDEN = 
		CASE WHEN ID = VID1 THEN VORDEN2
			WHEN ID = P_IDUSO THEN VORDEN1 END
	WHERE ID IN (P_IDUSO,VID1); 

EXCEPTION WHEN NO_DATA_FOUND THEN
	RAISE_APPLICATION_ERROR(-20002,'no puede BAJAS mas');
```
     
   
## DiametroActual (p_bobina)
```SQL
SELECT ROUND(DIAMETRO * SQRT(PSTOCK / 100),0) 
	INTO V_DIAMETRO 
	FROM BOB 
	WHERE ID = P_BOBINA; 
```
 
## PesoActual (p_bobina)
```SQL
SELECT ROUND (PESO * PSTOCK / 100) 
	INTO V_PESO 
	FROM BOB 
	WHERE ID = P_BOBINA;
```
 
## MetrosActual (p_bobina)
```SQL
SELECT ROUND (PESO * PSTOCK /GRAMAJE / FORMATO * 1000) 
	INTO V_METROS 
	FROM BOB 
	WHERE ID = P_BOBINA;
```
 
## MetrosUso (p_uso)
```SQL
SELECT ROUND (PESO * USO /REND /GRAMAJE / FORMATO * 1000)
	INTO V_METROS 
	FROM BOB_USO,BOB 
	WHERE BOB_USO.ID = P_USO 
	AND BOB_USO.BOBINA = BOB.ID;
```

## PrecioPapel (p_tipo)
```SQL  
SELECT PRECIO 
	INTO V_PRECIO
	FROM COTIZ_PAPEL
	WHERE TIPO_PAPEL = P_TIPO
	AND SYSDATE BETWEEN DESDE AND NVL(HASTA,SYSDATE);
```   

## Stock (p_tipo)
```SQL
SELECT FLOOR(SUM( PESO * PSTOCK) / 100) 
	INTO V_KILOS
	FROM BOB
	WHERE ESTADO IN (1,2)
	AND TIPO = P_TIPO;
```