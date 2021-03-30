# Wiki henry


## SAP PI

[Check communication channels](communication-channel)


## Oracol
[Common oracle sentences](oracle-sentences)

[Extend tablespace for PEX](oracle-extend-ts)

[View tablespace size](view-tablespace)

### Common alert.log on securex:
/oracle/SEP/saptrace/diag/rdbms/sep/SEP/alert

## PEX

### MySQL

[Typical problems on MySQL](pex-mysql)

### RoR

[Typical problems on RoR](pex-ror)

[Reusing a gem](reusing-gem)

[Check Resque Queues](pex-resque)

## Resque
[Problems on REDIS](redis-ror)


### EFT

[Typical problems on EFT](pex-eft)

### WebMethods
Default log folder:

```bash

/sag/IS_96/IntegrationServer/instances/default/logs>

```

[How to solve corruption on config](wm-corruption-config)


### PEX to SAP 
[configuration of PEX and SAP](pex-sap-config)


## SAP
[Stop start SAP](stop-start-sap)

## Install license on Javastack
[Install license on Javastack](install-license-javastack)

## Unistall SAP services:
[Link from sap.](https://websmp130.sap-ag.de/sap%28bD1lbiZjPTAwMQ==%29/bc/bsp/sno/ui_entry/entry.htm?param=69765F6D6F64653D3030312669765F7361706E6F7465735F6E756D6265723D3132353939383226)
```bash

/usr/sap/sapservices

```
### Vertex:

[1/2/16 11:56] Fatima Galera (fatima.galera@ngahr.com): helouse!
[1/2/16 11:56] Fatima Galera (fatima.galera@ngahr.com): xa el ticket INC1589970
[1/2/16 11:57] Fatima Galera (fatima.galera@ngahr.com): te creas un rdp... y ponle nfivtpdc01.northgate.erp
[usuario nis-sql
):password Ngatesap1
[1/2/16 11:57] Fatima Galera (fatima.galera@ngahr.com): Nos vamos a la carpeta: E:\vertex\sic_prd\bin
Ordenamos por fecha los archivos 
[1/2/16 11:57] Fatima Galera (fatima.galera@ngahr.com): y nos cargamos los CPI...mayores de 100MG, xo q no sea el ultimo


### CUA troubleshooting
[Entries in Transaction SM58 are in status "Transaction recorded"](http://wiki.scn.sap.com/wiki/pages/viewpage.action?pageId=145719978)

### Transport hang
[Transport hang](sap-transport-hang)

### Check SAP Cryptolib
[Sapcryptolib](sap-cryptolib)

### TAbles for SM69
```
SXPGCOSTAB
SXPGCOTABE
```

### SAPXPG
[SAPXPG troubleshooting guide](http://wiki.scn.sap.com/wiki/display/TechTSG/SAPXPG+-+External+Program+Troubleshooting+Guide)
Remember to setup ssh also to FQDN not only the short name!!


### WEBDISPATCHER:
Cleanup:
sapwebdisp pf= -cleanup  pf=/usr/sap/HW3/SYS/profile/HW3_W22_barwd3ci ![2016-02-01](http://git.eu.ngahr.com/uploads/joseenriquep/wikihenry/e47f872800/2016-02-01.png)
