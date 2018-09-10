SELECT 
	P."ID",
	"ART",
	P.CLIENTE,
	P.CLIENTE CLIENTE_ID,
	ART_PKG.SCODIGO(ART) CODIGO,
	ART_PKG.SQUARE_COLOR(COLOR) AS IMPRESION,
	ART_PKG.SUPERFICIE(ART) AS M2,
	"FECHA_PED",
	"FECHA_ENT", 
	"PEDIDO", 
	"ENTREGADO", 
	"COMBINADO", 
	"PLANCHAS", 
	"PRODUCCION", 
	"TERMINADO" + "SIN_CONTAR" TERMINADO,
	CASE 
		WHEN ENTREGADO + TERMINADO + SIN_CONTAR >= PEDIDO THEN 'BLUE'
		WHEN ENTREGADO + TERMINADO + SIN_CONTAR + PLANCHAS * A.MULT + PRODUCCION >= PEDIDO THEN 'GREEN'
		WHEN ENTREGADO + TERMINADO + SIN_CONTAR + (COMBINADO+PLANCHAS) * A.MULT + PRODUCCION >= PEDIDO THEN 'MEDIUMSEAGREEN'
		WHEN TERMINADO > 0 THEN 'DARKTURQUOISE'
		WHEN (COMBINADO+PLANCHAS) * A.MULT + PRODUCCION > 0 THEN 'LIGHTSALMON'
		ELSE 'ORANGE' END AS COLOR_1,
    P.OBS,
    CASE WHEN LENGTH(P.OBS)>0 
		THEN '<i class="fa fa-exclamation" style="color : red;"></i>' 
		ELSE '' END AS ICON_OBS,
    PEDIDO - (ENTREGADO + TERMINADO + SIN_CONTAR +
		(COMBINADO + PLANCHAS) * A.MULT + PRODUCCION) as A_FABRI
FROM VIEW_PEDIDOS P ,ART A
WHERE P.ART = A.ID;