//@echo off
echo Importando Facuras...

IF "%1"=="" (
	echo falta mes...
) else (
	sqlldr userid=VIC/AGOS2018 control=Cabecera.ctl data=CABECERA_%1.txt discard=log\CABECERA_%1.dis bad=log\CABECERA_%1.bad log=log\CABECERA_%1.log 

	sqlldr userid=VIC/AGOS2018 control=Detalle.ctl data=Detalle_%1.txt discard=log\Detalle_%1.dis bad=log\Detalle_%1.bad log=log\Detalle_%1.log

	SQLPLUS VIC/AGOS2018 @afip_import_facturas.sql
)
