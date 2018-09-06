#Afip

##Padron IIBB
Instructivo para actualizar valor de retencion de IIBB desde el padron publicado por Afip Mensualmente

Pasos a seguir:
- descargar archivo desde http://www.afip.gov.ar/genericos/cinscripcion/archivocompleto.asp
- importar a Oracle (tabla temporal)
- copiar valores a tabla CLI_IIBB

Preparacion :
- Tabla CLI_IIBB
- Tabla PADRON_ARBA
- Archivo import_padron.ctl
- comando Sql

'''
TABLA CLI_IIBB
- ID pk
- CUIT varchar(11)
- DESDE date
- HASTA date
- VALOR number
'''

![](https://raw.githubusercontent.com/Dani3lSun/apex-sample-code/master/ut-navbar-search/images/navbar_entry.pIg)

'''
TABLA PADRON_IIBB
- CUIT varchar(11)
- TIPO 
- FECHA
- DESDE
- HASTA
- P1
- P2
- P3
- VALOR
- GRUPO
'''
