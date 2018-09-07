-- Importa Archivo Cabecera.txt a Tabla Temporal

Load DATA 
	TRUNCATE
	INTO TABLE IMPORT_CABECERA
	(
		 Tipo_registro 				POSITION(01:01) INTEGER EXTERNAL,
		 Fecha_comprobante 			POSITION(02:09) CHAR,
		 Tipo_comprobante 			POSITION(10:11) CHAR,
		 Controlador_Fiscal 		POSITION(12:12) CHAR,
		 Punto_venta 				POSITION(13:16) CHAR,
		 NRO_comprobante 			POSITION(17:24) CHAR,
		 NRO_comprobante_registrado POSITION(25:32) CHAR,
		 Cantidad_hojas 			POSITION(33:35) CHAR,
		 Codigo_documento_comprador POSITION(36:37) CHAR,
		 NRO_documento_comprador 	POSITION(38:48) CHAR,
		 denominacion_comprador 	POSITION(49:78) CHAR,
		 Importe_total_operacion 	POSITION(79:93) CHAR,
		 Importe_total_no_gravado 	POSITION(94:108) CHAR,
		 Importe_neto_gravado 		POSITION(109:123) CHAR,
		 Impuesto_liquidado 		POSITION(124:138) CHAR,
		 Impuesto_liquidado_2 		POSITION(139:153) CHAR,
		 Importe_oper_exentas 		POSITION(154:168) CHAR,
		 Importe_percep_nac 		POSITION(169:183) CHAR,
		 Importe_percep_IIBB 		POSITION(184:198) CHAR,
		 Importe_percep_Muni 		POSITION(199:213) CHAR,
		 Importe_Imp_Internos 		POSITION(214:228) CHAR,
		 Transporte 				POSITION(229:243) CHAR,
		 Tipo_responsable 			POSITION(244:245) CHAR,
		 Codigos_moneda 			POSITION(246:248) CHAR,
		 Tipo_cambio 				POSITION(249:258) CHAR,
		 Cantidad_alicuotas_IVA 	POSITION(259:259) CHAR,
		 Codigo_operacion 			POSITION(260:260) CHAR,
		 CAI 						POSITION(261:274) CHAR,
		 Fecha_Vencimiento 			POSITION(275:282) CHAR,
		 Fecha_Anulacion 			POSITION(283:290) CHAR
	)
