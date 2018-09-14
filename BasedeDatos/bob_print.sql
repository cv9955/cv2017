CREATE OR REPLACE PACKAGE  "BOB_PRINT" as

procedure planilla (
   p_orden in number   default null);


    
procedure etiquetas (
    p_orden in number );
    
function qr (p_bobina number) return varchar;    
end;
/
CREATE OR REPLACE PACKAGE BODY  "BOB_PRINT" AS

  procedure planilla (
   p_orden in number default null) AS
   
   CURSOR CX IS
   SELECT BOB.ID,TIPO_PAPEL,FORMATO,GRAMAJE,DIAMETRO,PESO FROM BOB,BOB_TIPO
   WHERE ORDEN_INGRESO = p_orden AND BOB.TIPO = BOB_TIPO.ID
   ORDER BY 1;
   
   v_bobina cx%ROWTYPE;
   v_prov BOB_PROV.PROV%TYPE;
   v_fecha BOB_ORDEN.FECHA%TYPE;
   
  BEGIN
  
    SELECT bob_prov.PROV,bob_orden.fecha INTO v_prov,v_fecha from bob_prov,bob_orden
    where bob_orden.id = p_orden and bob_orden.prov = bob_prov.id;
    

    htp.p('<div class="cv_prov" >PROVEDOR: ' || v_prov || '</div>');
    htp.p('<div class="cv_fecha">FECHA: '||v_fecha|| '</div>');

  
    htp.p('<div class="cv_planilla">');
    htp.p('<table>');
    htp.p('<thead><tr>');
    htp.p('<th class="t-Report-colHead"  align="center"  id="ID" style="width:150px">NRO</th>');
    htp.p('<th class="t-Report-colHead"  align="center"  id="TIPO" style="width:200px">Tipo</th>');
    htp.p('<th class="t-Report-colHead"  align="center"  id="FORMATO" style="width:150px">Formato</th>');
    htp.p('<th class="t-Report-colHead"  align="center"  id="GRAMAJE" style="width:150px">Gramaje</th>');
    htp.p('<th class="t-Report-colHead"  align="center"  id="DIAMETRO" style="width:150px">Diametro</th>');
    htp.p('<th class="t-Report-colHead"  align="center"  id="KILOS" style="width:150px">Kilos</th>');
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
    if v_bobina.peso = 0 then
      htp.p('<td class="t-Report-cell"  headers="KILOS">' || '&nbsp;' ||'</td>');
    else
      htp.p('<td class="t-Report-cell"  headers="KILOS">' || v_bobina.peso ||'</td>');
    end if;
    htp.p('<td class="t-Report-cell"  headers="OBSERVACIONES">&nbsp;</td></tr>');
      
      END LOOP;
      CLOSE CX;

    htp.p('</tbody>');
    htp.p('</table>');

    
    htp.p('</div>');
    
  END planilla;
  procedure etiquetas (
    p_orden in number ) AS
  
   i_eti number;
   
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
   WHERE ORDEN_INGRESO = p_orden 
   AND BOB.TIPO = BOB_TIPO.ID
   AND BOB.ORDEN_INGRESO = BOB_ORDEN.ID
   AND BOB_ORDEN.PROV = BOB_PROV.ID
   ORDER BY 1;
   
   v_bobina cx%ROWTYPE;
   
  BEGIN
   i_eti := 1;
    OPEN CX;
    LOOP 
      FETCH CX INTO v_bobina;
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
      
      if i_eti = 2 then
        i_eti := 1;
        htp.p('<div class="page-break"></div>');
      else
        i_eti := i_eti + 1;
      end if;
      END LOOP;
      CLOSE CX;
    NULL;
  END etiquetas;
  


  function qr (p_bobina number) return varchar AS
  v_resp varchar(200);
  BEGIN
   select id || tipo || formato || gramaje into v_resp
   from bob where id = p_bobina;
   
    RETURN v_resp;
    
  END qr;

END BOB_PRINT;
/
