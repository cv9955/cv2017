CREATE OR REPLACE PACKAGE BODY BOB_PKG AS
	G_IDORDEN BOB_ORDEN.ID%TYPE;
	ID_BOBINA BOB.ID%TYPE;
	G_DIAMETRO NUMBER; -- CARGAR DIAMETRO INICIAL

PROCEDURE USAR (
	P_FECHA DATE, 
	P_LUGAR BOB_USO.LUGAR%TYPE, 
	P_BOBINA BOB_USO.BOBINA%TYPE,
	P_INICIO NUMBER,
	P_FIN NUMBER) AS

	V_ORDEN NUMBER;
	V_REND NUMBER;
	V_DIAMETRO NUMBER;
	V_DIAMETROACTUAL NUMBER;
	V_PSTOCK NUMBER;
	V_PRESTO NUMBER;
	V_PUSO NUMBER;  
BEGIN
	SELECT NVL(MAX(ORDEN)+1,0) 
	INTO V_ORDEN 
	FROM BOB_USO
	WHERE FECHA = P_FECHA 
	AND LUGAR = P_LUGAR;

	SELECT DIAMETRO,PSTOCK 
	INTO V_DIAMETRO,V_PSTOCK 
	FROM BOB
	WHERE ID = P_BOBINA;

	IF V_PSTOCK = 100 THEN
		UPDATE BOB
			SET DIAMETRO = P_INICIO
			WHERE ID = P_BOBINA;
		V_DIAMETRO := P_INICIO;
		V_DIAMETROACTUAL := P_INICIO;
	ELSE
		V_DIAMETROACTUAL := BOB_PKG.DIAMETROACTUAL(P_BOBINA);  
	END IF;

	IF P_FIN >= V_DIAMETROACTUAL THEN
		RAISE_APPLICATION_ERROR(-20001,'DIAMETRO FINAL DEBE SER MENOR QUE DIAMETRO ACTUAL');
	END IF;
	
	V_PRESTO := POWER(P_FIN / V_DIAMETRO,2)*100;
	V_PUSO := V_PSTOCK - V_PRESTO;
	
	IF P_LUGAR = 2 THEN
		V_REND := 1.35;
	ELSE
		V_REND := 1;
	END IF;
	
	INSERT INTO BOB_USO
		(FECHA,LUGAR,ORDEN,BOBINA,INICIO,FIN,USO,REND)
		VALUES(P_FECHA,P_LUGAR,V_ORDEN,P_BOBINA,V_DIAMETROACTUAL,P_FIN,V_PUSO,V_REND);
END USAR;

PROCEDURE ELIMINARUSO(P_IDUSO BOB_USO.ID%TYPE)	AS
	V_ORDEN BOB_USO.ORDEN%TYPE;
	V_FECHA BOB_USO.FECHA%TYPE;
	V_LUGAR BOB_USO.LUGAR%TYPE;
BEGIN
	SELECT FECHA,LUGAR,ORDEN 
		INTO V_FECHA,V_LUGAR,V_ORDEN
		FROM BOB_USO
		WHERE ID = P_IDUSO;
	
	DELETE FROM BOB_USO
		WHERE ID = P_IDUSO;
	
	UPDATE BOB_USO
		SET ORDEN = ORDEN -1
		WHERE FECHA = V_FECHA
		AND LUGAR = V_LUGAR
		AND ORDEN > V_ORDEN;
END ELIMINARUSO;

PROCEDURE SUBIRORDENUSO(P_IDUSO BOB_USO.ID%TYPE)	AS
	V_ORDEN BOB_USO.ORDEN%TYPE;
	V_FECHA BOB_USO.FECHA%TYPE;
	V_LUGAR BOB_USO.LUGAR%TYPE;
BEGIN
	SELECT FECHA,LUGAR,ORDEN 
		INTO V_FECHA,V_LUGAR,V_ORDEN
		FROM BOB_USO
		WHERE ID = P_IDUSO;

	IF V_ORDEN = 0 THEN
		RAISE_APPLICATION_ERROR(-20001,'NO PUEDE SUBIR MAS');
	END IF;

	UPDATE BOB_USO
		SET ORDEN =-1
		WHERE ID = P_IDUSO;

	UPDATE BOB_USO
		SET ORDEN = V_ORDEN 
		WHERE FECHA = V_FECHA
		AND LUGAR = V_LUGAR
		AND ORDEN = V_ORDEN -1;

	UPDATE BOB_USO
		SET ORDEN = V_ORDEN - 1
		WHERE ID = P_IDUSO;    
END SUBIRORDENUSO;

PROCEDURE BAJARORDENUSO(P_IDUSO BOB_USO.ID%TYPE)  AS
	V_ORDEN BOB_USO.ORDEN%TYPE;
	V_ORDEN_MAX BOB_USO.ORDEN%TYPE;
	V_FECHA BOB_USO.FECHA%TYPE;
	V_LUGAR BOB_USO.LUGAR%TYPE;
BEGIN
	SELECT FECHA,LUGAR,ORDEN 
		INTO V_FECHA,V_LUGAR,V_ORDEN
		FROM BOB_USO
		WHERE ID = P_IDUSO;

	SELECT MAX(ORDEN) INTO V_ORDEN_MAX
		FROM BOB_USO
		WHERE FECHA = V_FECHA
		AND LUGAR = V_LUGAR;

	IF V_ORDEN = V_ORDEN_MAX  THEN
		RAISE_APPLICATION_ERROR(-20001,'NO PUEDE BAJAR MAS');
	END IF;

	UPDATE BOB_USO
		SET ORDEN =-1
		WHERE ID = P_IDUSO;
		
	UPDATE BOB_USO
		SET ORDEN = V_ORDEN 
		WHERE FECHA = V_FECHA
		AND LUGAR = V_LUGAR
		AND ORDEN = V_ORDEN + 1;
		
	UPDATE BOB_USO
		SET ORDEN = V_ORDEN + 1
		WHERE ID = P_IDUSO; 
END BAJARORDENUSO;

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

FUNCTION DIAMETROACTUAL (P_BOBINA BOB.ID%TYPE) RETURN NUMBER IS	V_DIAMETRO NUMBER;
BEGIN 
	SELECT ROUND(DIAMETRO * SQRT(PSTOCK / 100),0) 
		INTO V_DIAMETRO 
		FROM BOB 
		WHERE ID = P_BOBINA;       
	
	RETURN V_DIAMETRO;
	EXCEPTION 
		WHEN NO_DATA_FOUND THEN	RETURN 0;
END DIAMETROACTUAL;

FUNCTION PESOACTUAL (P_BOBINA BOB.ID%TYPE) RETURN NUMBER IS	V_PESO NUMBER;
BEGIN
	SELECT ROUND (PESO * PSTOCK / 100) INTO V_PESO FROM BOB WHERE ID = P_BOBINA;
	RETURN V_PESO;
END PESOACTUAL;

FUNCTION METROSACTUAL (P_BOBINA BOB.ID%TYPE) RETURN NUMBER IS	V_METROS NUMBER;
BEGIN
	SELECT ROUND (PESO * PSTOCK /GRAMAJE / FORMATO * 1000) INTO V_METROS 
		FROM BOB WHERE ID = P_BOBINA;
	RETURN V_METROS;      
END METROSACTUAL;

FUNCTION METROSUSO (P_USO BOB_USO.ID%TYPE) RETURN NUMBER IS	V_METROS NUMBER;  
BEGIN
	SELECT ROUND (PESO * USO /REND /GRAMAJE / FORMATO * 1000) INTO V_METROS 
		FROM BOB_USO,BOB WHERE BOB_USO.ID = P_USO AND BOB_USO.BOBINA = BOB.ID;
	RETURN V_METROS;
END METROSUSO; 

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

FUNCTION METROSCORRUGADO (P_ID_CAB CABS_CORR_D.ID%TYPE) RETURN NUMBER IS
V_RET NUMBER;
BEGIN
SELECT ROUND(CANT_1 * PLARGO_1 / MULT_1 / NVL(MX_1,1) / 1000) INTO V_RET FROM CABS_CORR_D WHERE ID = P_ID_CAB;
RETURN V_RET;
END METROSCORRUGADO;

FUNCTION STOCK_VALORIZADO (PTIPO  BOB.TIPO%TYPE) RETURN NUMBER IS
	V_RET NUMBER;
BEGIN
	SELECT SUM( FLOOR(PESO * PSTOCK / 100))*COTIZ.GET_PRECIO_PAPEL(TIPO) INTO V_RET
		FROM BOB WHERE ESTADO IN (1,2) AND TIPO = PTIPO
		GROUP BY TIPO; 
	RETURN V_RET;
END STOCK_VALORIZADO;    
END BOB_PKG;