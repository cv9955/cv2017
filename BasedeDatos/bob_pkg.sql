create or replace PACKAGE  "BOB_PKG" AS  
  
    PROCEDURE SubirOrdenUso (p_idUso Bob_Uso.id%type); 
     
    PROCEDURE BajarOrdenUso (p_idUso Bob_Uso.id%type); 
     
    PROCEDURE IngresarOrden (p_idProv Bob_Prov.id%type, p_remito Number); 
     
    PROCEDURE IngresarBobinas (Cant  number,Tipo  bob.tipo%type,  Formato bob.formato%type,  Gramaje bob.gramaje%type); 
     
    FUNCTION DiametroActual (p_bobina bob.id%type) RETURN NUMBER ; 
 
    FUNCTION PesoActual (p_bobina bob.id%type) RETURN NUMBER ; 
 
    FUNCTION MetrosActual (p_bobina bob.id%type) RETURN NUMBER ; 
 
    FUNCTION MetrosUso (p_uso bob_uso.id%type) RETURN NUMBER ; 
 
    PROCEDURE EliminarOrden (p_orden Bob_Orden.id%type); 
     
    FUNCTION MetrosCorrugado (p_id_Cab Cabs_corr_d.id%type) RETURN NUMBER ;  
     
     
END BOB_PKG; 

CREATE OR REPLACE PACKAGE BODY BOB_PKG AS
	G_IDORDEN BOB_ORDEN.ID%TYPE;
	ID_BOBINA BOB.ID%TYPE;
	G_DIAMETRO NUMBER; -- CARGAR DIAMETRO INICIAL

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
				ORDER BY B1.ORDEN ASC )
			WHERE ROWNUM = 1;

		UPDATE BOB_USO
			SET ORDEN = CASE WHEN ID = VID1 THEN VORDEN2
			WHEN ID = p_iduso THEN VORDEN1 END
			where id in (p_iduso,VID1); 

	EXCEPTION 
		WHEN NO_DATA_FOUND THEN
			RAISE_APPLICATION_ERROR(-20001,'no puede bajar mas');
	END BajarOrdenUso;
  

PROCEDURE INGRESARORDEN(
	P_IDPROV BOB_PROV.ID%TYPE,
	P_REMITO NUMBER)  AS
BEGIN
	SELECT MAX(ID)+1 
		INTO G_IDORDEN 
		FROM BOB_ORDEN;
	
	SELECT NVL(DIAMETRO,0) 
		INTO G_DIAMETRO 
		FROM BOB_PROV
		WHERE ID = P_IDPROV;
	
	INSERT INTO BOB_ORDEN(ID,PROV,REMITO,FECHA)
		VALUES(G_IDORDEN,P_IDPROV,P_REMITO,SYSDATE());
END INGRESARORDEN;



PROCEDURE INGRESARBOBINAS(
	CANT NUMBER,
	TIPO BOB.TIPO%TYPE,
	FORMATO BOB.FORMATO%TYPE,
	GRAMAJE BOB.GRAMAJE%TYPE) AS
BEGIN
	IF G_IDORDEN IS NULL THEN
		SELECT MAX(ID) INTO G_IDORDEN FROM BOB_ORDEN;
	END IF;
	
	SELECT MAX(ID) INTO ID_BOBINA FROM BOB;
	
	FOR I IN 1..CANT LOOP
		ID_BOBINA := ID_BOBINA + 1;
		INSERT INTO BOB(ID,TIPO,FORMATO,GRAMAJE,PESO,DIAMETRO,PSTOCK,ESTADO,ORDEN_INGRESO)
			VALUES(ID_BOBINA,TIPO,FORMATO,GRAMAJE,0,NVL(G_DIAMETRO,120),100,0,G_IDORDEN);
	END LOOP;
END INGRESARBOBINAS;

PROCEDURE ELIMINARORDEN (P_ORDEN BOB_ORDEN.ID%TYPE) AS V_BOBINASUSADAS NUMBER;
BEGIN
	SELECT COUNT(BOB_USO.ID) INTO V_BOBINASUSADAS FROM BOB_USO,BOB
		WHERE BOB_USO.BOBINA = BOB.ID
		AND BOB.ORDEN_INGRESO = P_ORDEN ;
	IF V_BOBINASUSADAS > 0 THEN 
		RAISE_APPLICATION_ERROR(-20002,'NO SE PUEDE ELIMINAR LA ORDEN BOBINAS YA USADAS!!');
	ELSE 
		DELETE FROM BOB
			WHERE ORDEN_INGRESO = P_ORDEN;
		DELETE FROM BOB_ORDEN
			WHERE ID = P_ORDEN;
	END IF; 
END ELIMINARORDEN;



	FUNCTION DIAMETROACTUAL (P_BOBINA BOB.ID%TYPE) RETURN NUMBER IS
		V_DIAMETRO NUMBER;
	BEGIN 
		SELECT ROUND(DIAMETRO * SQRT(PSTOCK / 100),0) 
			INTO V_DIAMETRO 
			FROM BOB 
			WHERE ID = P_BOBINA;       

		RETURN V_DIAMETRO;
		
		EXCEPTION 
			WHEN NO_DATA_FOUND THEN	RETURN 0;
	END DIAMETROACTUAL;

	FUNCTION PESOACTUAL (P_BOBINA BOB.ID%TYPE) RETURN NUMBER IS
		V_PESO NUMBER;
	BEGIN
		SELECT ROUND (PESO * PSTOCK / 100) 
			INTO V_PESO 
			FROM BOB 
			WHERE ID = P_BOBINA;
			
		RETURN V_PESO;
		
		EXCEPTION 
			WHEN NO_DATA_FOUND THEN	RETURN 0;
	END PESOACTUAL;

	FUNCTION METROSACTUAL (P_BOBINA BOB.ID%TYPE) RETURN NUMBER IS
		V_METROS NUMBER;
	BEGIN
		SELECT ROUND (PESO * PSTOCK /GRAMAJE / FORMATO * 1000) 
			INTO V_METROS 
			FROM BOB 
			WHERE ID = P_BOBINA;
		
		RETURN V_METROS;  
		
		EXCEPTION 
			WHEN NO_DATA_FOUND THEN	RETURN 0;
	END METROSACTUAL;

	FUNCTION METROSUSO (P_USO BOB_USO.ID%TYPE) RETURN NUMBER IS
		V_METROS NUMBER;  
	BEGIN
		SELECT ROUND (PESO * USO /REND /GRAMAJE / FORMATO * 1000)
			INTO V_METROS 
			FROM BOB_USO,BOB 
			WHERE BOB_USO.ID = P_USO 
			AND BOB_USO.BOBINA = BOB.ID;
			
		RETURN V_METROS;
		
		EXCEPTION 
			WHEN NO_DATA_FOUND THEN	RETURN 0;	
	END METROSUSO; 

	FUNCTION METROSCORRUGADO (P_ID_CAB CABS_CORR_D.ID%TYPE) RETURN NUMBER IS
		V_RET NUMBER;
	BEGIN
		SELECT ROUND(CANT_1 * PLARGO_1 / MULT_1 / NVL(MX_1,1) / 1000)
			INTO V_RET 
			FROM CABS_CORR_D 
			WHERE ID = P_ID_CAB;
		
		RETURN V_RET;
		
		EXCEPTION 
			WHEN NO_DATA_FOUND THEN	RETURN 0;
	END METROSCORRUGADO;

	FUNCTION STOCK_VALORIZADO (PTIPO  BOB.TIPO%TYPE) RETURN NUMBER IS
		V_RET NUMBER;
	BEGIN
		SELECT SUM(FLOOR(PESO * PSTOCK / 100)) * COTIZ.GET_PRECIO_PAPEL(TIPO)
			INTO V_RET
			FROM BOB WHERE ESTADO IN (1,2) AND TIPO = PTIPO
			GROUP BY TIPO; 
			
		RETURN V_RET;
		
	END STOCK_VALORIZADO;    
END BOB_PKG;