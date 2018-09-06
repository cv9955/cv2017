Load DATA 
TRUNCATE
INTO TABLE IMPORT_DETALLE
(
    tipo_comprobante        POSITION(01:02) CHAR,    
    controlador_fiscal      POSITION(03:03) CHAR,      
    fecha_comprobante        POSITION(04:11) CHAR,     
    punto_venta                POSITION(12:15) CHAR,   
    nro_comprobante             POSITION(16:23) CHAR,
    nro_comprobante_registrado  POSITION(24:31) CHAR,
    cantidad                     POSITION(32:43) CHAR,
    unidad_medida               POSITION(44:45) CHAR, 
    precio_unitario              POSITION(46:61) CHAR,
    importe_bonificacion        POSITION(62:76) CHAR,
    importe_ajuste              POSITION(77:92) CHAR,
    subtotal                    POSITION(93:108) CHAR,
    alicuota_iva               POSITION(109:112) CHAR,  
    modo                       POSITION(113:113) CHAR, 
    anulado                    POSITION(114:114) CHAR,   
    texto    					POSITION(115:189) CHAR
)
