
*** BUSCAR POR PRIMERAS LETRAS DE RAZON 

SELECT R.ROWID,R.FECHA,R.RECIBO,R.RAZON,D.RAZON_SOCIAL, D.ID FROM IMP_RECIBOS R,CLI_DFISCAL D
WHERE  D.RAZON_SOCIAL LIKE SUBSTR(R.RAZON,0,3) || '%'
AND  R.ID_RAZON IS NULL
AND R.ROWID IN (SELECT R.ROWID FROM IMP_RECIBOS R,CLI_DFISCAL D
WHERE  D.RAZON_SOCIAL LIKE SUBSTR(R.RAZON,0,3) || '%'
AND  R.ID_RAZON IS NULL
GROUP BY R.ROWID HAVING (COUNT(D.ID) = 1))
ORDER BY RAZON
;

UPDATE IMP_RECIBOS R
SET id_razon =
(SELECT D.ID FROM CLI_DFISCAL D
    WHERE  D.RAZON_SOCIAL LIKE SUBSTR(R.RAZON,0,3) || '%')
WHERE R.ROWID IN (SELECT R1.ROWID FROM IMP_RECIBOS R1,CLI_DFISCAL D1
        WHERE  D1.RAZON_SOCIAL LIKE SUBSTR(R1.RAZON,0,3) || '%'
        AND  R1.ID_RAZON IS NULL
        GROUP BY R1.ROWID HAVING (COUNT(D1.ID) = 1));
	
	
		