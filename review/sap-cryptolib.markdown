# SAP CRYPTOLIB
For each application server, set the environment variable SECUDIR to the

$DIR_INSTANCE/sec directory for the application server's user. (For UNIX, set it in the 

application server's startup scripts, For Windows, set it in <SID>adm's environment.)

To do this follow this steps:

type “cd” at prompt  This makes you go to /home directory  , now type ls -la

You will have to modify .sapenv_<SID>.csh  and .sapenv_<SID>.sh

Example at EP5:

```bash

eu2r3pci:ep5adm 121> more .sapenv_eu2r3pci.csh

# @(#) $Id: //bc/640-2/src/ins/SAPINST/impl/tpls/ind/ind/SAPENV.CSH#6 $ SAP

# SAP R/3 Environment - please do not edit

setenv SAPSYSTEMNAME  EP5

setenv DIR_LIBRARY    /usr/sap/EP5/SYS/exe/run

setenv SECUDIR /usr/sap/EP5/DVEBMGS20/sec

eu2r3pci:ep5adm 122> more .sapenv_eu2r3pci.sh

# @(#) $Id$ SAP

# SAP R/3 Environment - please do not edit

SECUDIR = /usr/sap/EP5/DVEBMGS20/sec; EXPORT SECUDIR

SAPSYSTEMNAME=EP5; export SAPSYSTEMNAME

DIR_LIBRARY=/usr/sap/EP5/SYS/exe/run; export DIR_LIBRARY

```
