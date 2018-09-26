CREATE OR REPLACE PACKAGE  "BOB_PRINT" AS
	PROCEDURE PLANILLA 	(P_ORDEN IN NUMBER);
	PROCEDURE ETIQUETAS (P_ORDEN IN NUMBER);
END;
/

CREATE OR REPLACE PACKAGE BODY  "BOB_PRINT" AS

	PROCEDURE PLANILLA (P_ORDEN IN NUMBER) AS
		CURSOR CX IS
			SELECT BOB.ID,TIPO_PAPEL,FORMATO,GRAMAJE,DIAMETRO,PESO 
				FROM BOB,BOB_TIPO
				WHERE ORDEN_INGRESO = P_ORDEN 
				AND BOB.TIPO = BOB_TIPO.ID
				ORDER BY 1;

		V_BOBINA 	CX%ROWTYPE;
		V_PROV 		BOB_PROV.PROV%TYPE;
		V_FECHA 	BOB_ORDEN.FECHA%TYPE;

	BEGIN
		SELECT BOB_PROV.PROV,BOB_ORDEN.FECHA 
			INTO V_PROV,V_FECHA 
			FROM BOB_PROV,BOB_ORDEN
			WHERE BOB_ORDEN.ID = P_ORDEN 
			AND BOB_ORDEN.PROV = BOB_PROV.ID;

		htp.p('<div class="cv_prov" >PROVEDOR: ' || v_prov || '</div>');
		htp.p('<div class="cv_fecha">FECHA: '||v_fecha|| '</div>');

		htp.p('<div class="cv_planilla">');
			htp.p('<table>');
				htp.p('<thead><tr>');
					htp.p('<th class="t-Report-colHead"  align="center"  id="ID" 		style="width:150px">NRO</th>');
					htp.p('<th class="t-Report-colHead"  align="center"  id="TIPO" 		style="width:200px">Tipo</th>');
					htp.p('<th class="t-Report-colHead"  align="center"  id="FORMATO" 	style="width:150px">Formato</th>');
					htp.p('<th class="t-Report-colHead"  align="center"  id="GRAMAJE" 	style="width:150px">Gramaje</th>');
					htp.p('<th class="t-Report-colHead"  align="center"  id="DIAMETRO" 	style="width:150px">Diametro</th>');
					htp.p('<th class="t-Report-colHead"  align="center"  id="KILOS" 	style="width:150px">Kilos</th>');
					htp.p('<th class="t-Report-colHead"  align="center"  id="OBSERVACIONES" >Observaciones</th>');
				htp.p('</tr></thead>');
				htp.p('<tbody>');

		OPEN CX;
			LOOP 
				FETCH CX INTO v_bobina;
				EXIT WHEN CX%NOTFOUND;

					htp.p('<tr><td class="t-Report-cell"  align="center"  headers="ID">' || v_bobina.id || '</td>');
					htp.p('<td class="t-Report-cell"  headers="TIPO">' || v_bobina.tipo_papel || '</td>');
					htp.p('<td class="t-Report-cell"  headers="FORMATO">' || v_bobina.formato || '</td>');
					htp.p('<td class="t-Report-cell"  headers="GRAMAJE">' || v_bobina.gramaje || '</td>');
					htp.p('<td class="t-Report-cell"  headers="DIAMETRO">' || v_bobina.diametro ||'</td>');
				IF V_BOBINA.PESO = 0 THEN
					htp.p('<td class="t-Report-cell"  headers="KILOS">' || '&nbsp;' ||'</td>');
				ELSE
					htp.p('<td class="t-Report-cell"  headers="KILOS">' || v_bobina.peso ||'</td>');
				END IF;
					htp.p('<td class="t-Report-cell"  headers="OBSERVACIONES">&nbsp;</td></tr>');
			END LOOP;
		CLOSE CX;

				htp.p('</tbody>');
			htp.p('</table>');
		htp.p('</div>');
	END PLANILLA;
  
  
	PROCEDURE ETIQUETAS (P_ORDEN IN NUMBER ) AS
		I_ETI NUMBER;
		CURSOR CX IS
			SELECT BOB.ID AS NRO,
				BOB_TIPO.KEY AS TIPO,
				BOB.FORMATO,
				BOB.GRAMAJE,
				BOB.DIAMETRO,
				BOB.PESO,
				BOB_PROV.PROV,
				BOB_ORDEN.ID AS ORDEN,
				BOB_ORDEN.FECHA AS FECHA
			FROM BOB,BOB_TIPO,BOB_PROV,BOB_ORDEN
			WHERE ORDEN_INGRESO = P_ORDEN 
				AND BOB.TIPO = BOB_TIPO.ID
				AND BOB.ORDEN_INGRESO = BOB_ORDEN.ID
				AND BOB_ORDEN.PROV = BOB_PROV.ID
			ORDER BY 1;

		V_BOBINA CX%ROWTYPE;
	BEGIN
		I_ETI := 1;
		OPEN CX;
			LOOP 
			FETCH CX INTO V_BOBINA;
			EXIT WHEN CX%NOTFOUND;
		htp.p('<div class="label">');
			htp.p('<table class="cv_etiq">');
				htp.p('<tr><td class="cv_nro">' || v_bobina.nro || '</td></tr>');
				htp.p('<tr><td class="cv_formato">' || v_bobina.formato ||  '</td></tr>');
				htp.p('<tr><td><table style="width:100%"><tr>');
						htp.p('<td class="cv_celda" >Orden Ingreso</td>');
						htp.p('<td class="cv_celda" >Proveedor</td>');
						htp.p('<td class="cv_celda">Fecha Ingreso</td>');
					htp.p('</tr><tr>');
						htp.p('<td class="cv_celda" >' || v_bobina.orden || '</td>');
						htp.p('<td class="cv_celda" >' || v_bobina.prov || '</td>');
						htp.p('<td class="cv_celda">'    ||v_bobina.fecha|| '</td>');    
				htp.p('</tr></table></td></tr>'); 

				htp.p('<tr><td class="cv_border_top"><table style="width:100%"><tr>');
					htp.p('<td class="cv_tipo">' || v_bobina.tipo || '</td>');
					htp.p('<td class="cv_tipo">' || v_bobina.gramaje || 'g</td>');
				htp.p('</tr></table></td></tr>'); 

				htp.p('<tr><td class="cv_border_top"><table style="width:100%"><tr>');
					htp.p('<td class="cv_nro2">' || v_bobina.nro || '</td>');
					htp.p('<td class="cv_nro2">' || v_bobina.nro || '</td>');
					htp.p('<td class="cv_nro2">' || v_bobina.nro || '</td>');
					htp.p('<td class="cv_nro2">' || v_bobina.nro || '</td>');
					htp.p('<td class="cv_nro2">' || v_bobina.nro || '</td>');
				htp.p('</tr></table></td></tr>'); 
			htp.p('</table>');
		htp.p('</div>');

				IF I_ETI = 2 THEN
					I_ETI := 1;
					htp.p('<div class="page-break"></div>');
				ELSE
					I_ETI := I_ETI + 1;
				END IF;
			END LOOP;
		CLOSE CX;
	END ETIQUETAS;

END BOB_PRINT;
/
