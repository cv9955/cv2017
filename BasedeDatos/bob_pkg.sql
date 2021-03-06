<<<<<<< HEAD
CREATE OR REPLACE PACKAGE BOB_PKG AS 
    PROCEDURE SUBIRORDENUSO (P_IDUSO BOB_USO.ID%TYPE);
    PROCEDURE BAJARORDENUSO (P_IDUSO BOB_USO.ID%TYPE);
    FUNCTION DIAMETROACTUAL (P_BOBINA BOB.ID%TYPE) RETURN NUMBER ;
    FUNCTION PESOACTUAL (P_BOBINA BOB.ID%TYPE) RETURN NUMBER ;
    FUNCTION METROSACTUAL (P_BOBINA BOB.ID%TYPE) RETURN NUMBER ;
    FUNCTION METROSUSO (P_USO BOB_USO.ID%TYPE) RETURN NUMBER ;
    FUNCTION PRECIOPAPEL (P_TIPO BOB_TIPO.ID%TYPE) RETURN NUMBER;
    FUNCTION STOCK (P_TIPO BOB_TIPO.ID%TYPE) RETURN NUMBER;	
=======
create or replace PACKAGE BOB_PKG AS 
	PROCEDURE SUBIRORDENUSO (P_IDUSO BOB_USO.ID%TYPE);
	PROCEDURE BAJARORDENUSO (P_IDUSO BOB_USO.ID%TYPE);
	FUNCTION DIAMETROACTUAL (P_BOBINA BOB.ID%TYPE) RETURN NUMBER ;
	FUNCTION PESOACTUAL (P_BOBINA BOB.ID%TYPE) RETURN NUMBER ;
	FUNCTION METROSACTUAL (P_BOBINA BOB.ID%TYPE) RETURN NUMBER ;
	FUNCTION METROSUSO (P_USO BOB_USO.ID%TYPE) RETURN NUMBER ;
	FUNCTION SDIAMETROS (P_USO BOB_USO.ID%TYPE) RETURN VARCHAR2 ;
	FUNCTION PRECIOPAPEL (P_TIPO BOB_TIPO.ID%TYPE) RETURN NUMBER;
	FUNCTION STOCK (P_TIPO BOB_TIPO.ID%TYPE) RETURN NUMBER;
>>>>>>> 57faa805c097404bd15a70ef5f6799843c77d47a
END BOB_PKG;

CREATE OR REPLACE PACKAGE BODY BOB_PKG AS
	PROCEDURE SUBIRORDENUSO(P_IDUSO BOB_USO.ID%TYPE)  AS
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
					AND B2.ID = P_IDUSO
					ORDER BY B1.ORDEN DESC)
            WHERE ROWNUM = 1;
 
        UPDATE BOB_USO
        SET ORDEN = CASE WHEN ID = VID1 THEN VORDEN2
                         WHEN ID = P_IDUSO THEN VORDEN1 END
            WHERE ID IN (P_IDUSO,VID1);     
    EXCEPTION 
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20001,'NO PUEDE SUBIR MAS');
	END SUBIRORDENUSO;
  
	PROCEDURE BAJARORDENUSO(P_IDUSO BOB_USO.ID%TYPE)  AS
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
					AND B2.ID = P_IDUSO
					ORDER BY B1.ORDEN ASC)
				WHERE ROWNUM = 1;
    
        UPDATE BOB_USO
			SET ORDEN = CASE WHEN ID = VID1 THEN VORDEN2
                         WHEN ID = P_IDUSO THEN VORDEN1 END
            WHERE ID IN (P_IDUSO,VID1); 
    
    EXCEPTION 
        WHEN NO_DATA_FOUND THEN RAISE_APPLICATION_ERROR(-20001,'NO PUEDE BAJAR MAS');
	END BAJARORDENUSO;

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
		
<<<<<<< HEAD
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
=======
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

FUNCTION SDIAMETROS (P_USO BOB_USO.ID%TYPE) RETURN VARCHAR2 IS
	V_DIAM VARCHAR2(20);  
BEGIN
	SELECT	TO_CHAR(INICIO,'9000') || ' ->' || TO_CHAR(FIN,'9000') 
		INTO V_DIAM 
		FROM BOB_USO 
		WHERE BOB_USO.ID = P_USO ;
	RETURN V_DIAM;	
	EXCEPTION 
		WHEN NO_DATA_FOUND THEN	RETURN '---';	
END SDIAMETROS; 

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

>>>>>>> 57faa805c097404bd15a70ef5f6799843c77d47a
	
    FUNCTION PRECIOPAPEL (P_TIPO BOB_TIPO.ID%TYPE) RETURN NUMBER IS
        V_PRECIO NUMBER;
    BEGIN
        SELECT PRECIO INTO V_PRECIO
            FROM COTIZ_PAPEL
            WHERE TIPO_PAPEL = P_TIPO
            AND SYSDATE BETWEEN DESDE AND NVL(HASTA,SYSDATE);

        RETURN V_PRECIO;

	EXCEPTION 
			WHEN NO_DATA_FOUND THEN	RETURN 0;	
	END PRECIOPAPEL;   
    
    FUNCTION STOCK (P_TIPO BOB_TIPO.ID%TYPE) RETURN NUMBER IS
        V_KILOS NUMBER;
    BEGIN
        SELECT FLOOR(SUM( PESO * PSTOCK) / 100) INTO V_KILOS
				FROM BOB
				WHERE ESTADO IN (1,2)
				AND TIPO = P_TIPO;

        RETURN V_KILOS;

 	EXCEPTION 
			WHEN NO_DATA_FOUND THEN	RETURN 0;	   
    END STOCK;
	
END BOB_PKG;