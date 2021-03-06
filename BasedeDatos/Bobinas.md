# Bobinas

### Esquema
![BOBINAS](/img/Bobinas.png)

## BOB_PROV
Lista de Provedores de Papel
```SQL
CREATE TABLE  "BOB_PROV" 
   (	"ID" NUMBER NOT NULL ENABLE, 
	"PROV" VARCHAR2(30) NOT NULL ENABLE, 
	"CREATED_BY" VARCHAR2(20), 
	"CREATED_FEC" DATE, 
	 CONSTRAINT "BOB_PROV_PK" PRIMARY KEY ("ID") ENABLE
   )
```
- **ACTIVO**: SI / NO
- **DIAMETRO**: Diametro inicial al ingresar bobinas nuevas

## BOB_ORDEN
Ordenes de Ingreso / Remito de Compra
```SQL
CREATE TABLE  "BOB_ORDEN" 
   (	"ID" NUMBER NOT NULL ENABLE, 
	"PROV" NUMBER, 
	"REMITO" NUMBER, 
	"FECHA" DATE, 
	"CREATED_BY" VARCHAR2(20), 
	"CREATED_FEC" DATE, 
	 CONSTRAINT "BOB_ORDEN_PK" PRIMARY KEY ("ID") ENABLE
   )
```
#### Relaciones
- PROV :key:BOB_PROV.ID

## BOB
Listado Principal
```SQL
CREATE TABLE  "BOB" 
   (	"ID" NUMBER NOT NULL ENABLE, 
	"TIPO" NUMBER NOT NULL ENABLE, 
	"FORMATO" NUMBER NOT NULL ENABLE, 
	"GRAMAJE" NUMBER NOT NULL ENABLE, 
	"PESO" NUMBER NOT NULL ENABLE, 
	"DIAMETRO" NUMBER, 
	"PSTOCK" NUMBER DEFAULT 100 NOT NULL ENABLE, 
	"ESTADO" NUMBER, 
	"CREATED_BY" VARCHAR2(20), 
	"CREATED_FEC" DATE, 
	"ORDEN_INGRESO" NUMBER NOT NULL ENABLE, 
	 CONSTRAINT "BOB_PK" PRIMARY KEY ("ID") ENABLE
   )
```
- TIPO :key:BOB_TIPO.ID 
- ESTADO :key:BOB_ESTADO.ID
- ORDEN_INGRESO :key:BOB_ORDEN.ID

#### Comentarios
- FORMATO: ancho de papel [cm]
- GRAMAJE: peso por metro cuadrado [grs/m2] 
- PESO : peso total [kg]
- PSTOCK : porcentaje de stock [0 - 100]

## BOB_USO
```SQL
CREATE TABLE  "BOB_USO" 
   (	"ID" NUMBER NOT NULL ENABLE, 
	"FECHA" DATE, 
	"LUGAR" NUMBER, 
	"ORDEN" NUMBER, 
	"BOBINA" NUMBER, 
	"INICIO" NUMBER, 
	"FIN" NUMBER, 
	"USO" NUMBER, 
	"REND" NUMBER, 
	"CREATED_BY" VARCHAR2(20), 
	"CREATED_FEC" DATE, 
	 CONSTRAINT "BOB_USO_PK" PRIMARY KEY ("ID") ENABLE
   )
```
#### Relaciones
- LUGAR	:key:BOB_LUGAR.ID
- BOBINA :key:BOB.ID
#### Comentarios
- ORDEN: [0..N] ordena dentro de su lugar de uso [FECHA / LUGAR / ORDEN]
- INICIO : Diametro de la bobina al iniciar su uso
- FIN: Diametro de la bobina al finalizar su uso 
  - Cero indica que se termino
- USO: Porcentaje de kilos utilizados 
- REND: ajuste de rendimiento
  - TAPAS -> 1
  - ONDA -> 1,5
  
