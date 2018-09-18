create or replace PROCEDURE "PRINT_REMITO"(
    pENTREGA_ID IN NUMBER,   pAREA  IN VARCHAR)
AS
  vRemito  CABS_ENTREGAS_M%ROWTYPE;
  vDfiscal CLI_DFISCAL%ROWTYPE;
  vItem CABS_ENTREGAS%ROWTYPE;
  vDir_Entrega varchar2(200);
  vHor_Entrega varchar2(200);
  
  CURSOR CX IS
  SELECT * FROM CABS_ENTREGAS
  WHERE ID_CAB = pENTREGA_ID;
  
BEGIN

  SELECT * INTO vRemito  FROM CABS_ENTREGAS_M  WHERE ID = pENTREGA_ID;
  SELECT * INTO vDfiscal FROM CLI_DFISCAL WHERE ID = vRemito.DFISCAL;
  
  
  IF (pAREA = 'HEADER') THEN
   htp.p('<div class="grid-container" style = "grid-template-rows: 4.8cm 1.8cm 2cm 10cm 5cm;">');
      htp.p('<div class="grid-container" style = "grid-template-columns: 10cm 1cm auto;">');
          htp.p('<div class="grid-title screenOnly">');
            htp.p('<h1>Victoria Corrugados S.A.</h1>');
            htp.p('<p>Fabrica de Envases de Carton Corrugado</p>');
            htp.p('<p>IVA Responable Inscripto</p>');
          htp.p('</div>');
           htp.p('<div class="grid-title screenOnly">');
            htp.p('<h1>R</h1>');
          htp.p('</div>');         
           htp.p('<div class="grid-title screenOnly">');
            htp.p('<h1>Nº0001 - '||vRemito.remito||'</h1>');
            htp.p('<p>Fecha:</p>');
            htp.p('<p style="text-align: center;">CUIT.:  30-67617517-9</p>');
          htp.p('</div>');         
          htp.p('<div class="grid-fecha">'|| TO_CHAR(vRemito.fecha,'DD/MM/YYYY') ||'</div>');

      htp.p('</div>');    

      htp.p('<div class="grid-container" style = "grid-template-columns: 2cm 9cm 2cm auto;">');
          htp.p('<div class="grid-title">');
              htp.p('<p class="screenOnly">Señore(es):</p>');
          htp.p('</div>');
          htp.p('<div class="grid-rsocial" style="grid-column: 2/5";>'|| vDfiscal.RAZON_SOCIAL ||'</div>');
          
          htp.p('<div class="grid-title">');
              htp.p('<p class="screenOnly">Domicilio:</p>');
          htp.p('</div>');          
          htp.p('<div class="grid-rsocial">'|| vDfiscal.DOMICILIO ||'</div>');
          
          htp.p('<div class="grid-title" >');
              htp.p('<p class="screenOnly">Localidad:</p>');
          htp.p('</div>');        
          htp.p('<div class="grid-rsocial">'|| vDfiscal.CIUDAD ||'</div>');
      htp.p('</div>');    

      htp.p('<div class="grid-container" style = "grid-template-columns: 9cm auto;">');          
            htp.p('<div class="grid-title" >');
              htp.p('<p class="screenOnly">IVA</p>');
          htp.p('</div>');         
            htp.p('<div class="grid-title" >');
              htp.p('<p class="screenOnly">CUIT Nº</p>');
          htp.p('</div>');       
         htp.p('<div class="grid-cuit" s>'|| TO_CHAR(vDfiscal.CUIT,'9999999999999') ||'</div>');   
      htp.p('</div>');    

-- ITEMS
      htp.p('<div class="grid-container" style = "grid-template-columns: 2.5cm auto;
      grid-template-rows: 1cm 0.6cm 0.6cm 0.6cm 0.6cm 0.6cm 0.6cm 0.6cm 0.6cm 0.6cm 0.6cm ;
      grid-column-gap: 50px;  ">');
            htp.p('<div class="grid-title" >');
              htp.p('<p class="screenOnly">CANTIDAD</p>');
          htp.p('</div>');         
            htp.p('<div class="grid-title" >');
              htp.p('<p class="screenOnly" style="text-align:center";>D E S C R I P C I O N</p>');
          htp.p('</div>');       
      --bucle items    
      OPEN CX;
      LOOP 
        FETCH CX INTO vItem;
        EXIT WHEN cx%NOTFOUND;
            htp.p('<div class="grid-title" >');
              htp.p('<p style="text-align:right;" >'||vItem.Cant||'</p>');
            htp.p('</div>');     
          
          
         htp.p('<div class="grid-title" ><p>');
         if vItem.Art is not null then 
              htp.p(art_pkg.sDetalle(vItem.Art) ||' - ('||art_pkg.smedidas(vItem.Art)||')<span class="tab">');
         end if;    
         if vItem.detalle is not null then
              htp.p(vItem.Detalle);
         end if;
           
          htp.p('</p></div>');   
          
 



        END LOOP;
      CLOSE CX;      
      htp.p('</div>'); 
      
      -- entrega
      htp.p('<div class="grid-container" style = "grid-template-columns: 2.5cm auto;
      grid-template-rows: 2cm 1cm 1cm 1cm;">');
            htp.p('<div class="grid-title" style="text-align:right;" >NOTAS :</div>');
            htp.p('<div><span class="grid-title">'||vRemito.notas||'</div>');            

		IF vRemito.Deposito IS NOT NULL THEN      
            SELECT HORARIO ,
            ROUTE || ' ' || STREET_NUMBER || ', ' || LOCALITY
            INTO vHor_Entrega,vDir_Entrega
            FROM CLI_DEPOSITO WHERE ID = vRemito.Deposito;
            htp.p('<div class="grid-title" style="text-align:right;" >ENTREGA :</div>');
            htp.p('<div><span class="grid-title">'||vDir_Entrega||'</div>');
            htp.p('<div class="grid-title" style="text-align:right;" >HORARIO :</div>');
            htp.p('<div><span class="grid-title">'||vHor_Entrega||'</div>');
            htp.p('<div class="grid-title" style="text-align:right;" >BULTO :</div>');
            htp.p('<div><span class="tab"></div>');
     ELSE
            htp.p('<div class="grid-title" style="text-align:right;" >ENTREGA :</div>');
            htp.p('<div><span class="tab"></div>');
            htp.p('<div class="grid-title" style="text-align:right;" >HORARIO :</div>');
            htp.p('<div><span class="tab"></div>');
            htp.p('<div class="grid-title" style="text-align:right;" >BULTO :</div>');
            htp.p('<div><span class="tab"></div>');
    END IF;
    
     htp.p('</div>');    
      
      
   htp.p('</div>');      
  END IF;
  
END PRINT_REMITO;