# BOB_PKG  
     
## SubirOrdenUso
Alterna el Orden diario hacia arriba 
```SQL
PROCEDURE SubirOrdenUso(p_idUso Bob_Uso.id%type)  AS
	VID1 NUMBER;
	VORDEN1 NUMBER;
	VORDEN2 NUMBER;
BEGIN
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

EXCEPTION 
	WHEN NO_DATA_FOUND THEN
		RAISE_APPLICATION_ERROR(-20001,'no puede SUBIR mas');

END SubirOrdenUso;
```	
    
## BajarOrdenUso
Alterna el Orden diario hacia arriba 
```SQL
PROCEDURE BajarOrdenUso(p_idUso Bob_Uso.id%type)  AS
	VID1 NUMBER;
	VORDEN1 NUMBER;
	VORDEN2 NUMBER;

BEGIN
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
				WHEN ID = p_iduso THEN VORDEN1 END
		where id in (p_iduso,VID1); 

EXCEPTION 
	WHEN NO_DATA_FOUND THEN
		RAISE_APPLICATION_ERROR(-20001,'no puede bajar mas');

END BajarOrdenUso;
```
     
## PROCEDURE IngresarOrden (p_idProv, p_remito)
     
## PROCEDURE IngresarBobinas (Cant, Tipo, Formato, Gramaje)
     
## FUNCTION DiametroActual (p_bobina) RETURN NUMBER
 
## FUNCTION PesoActual (p_bobina) RETURN NUMBER
 
## FUNCTION MetrosActual (p_bobina) RETURN NUMBER
 
## FUNCTION MetrosUso (p_uso) RETURN NUMBER
 
## PROCEDURE EliminarOrden (p_orden)
     
## FUNCTION MetrosCorrugado (p_id_Cab) RETURN NUMBER
     

