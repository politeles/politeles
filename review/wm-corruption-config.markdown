I suspect one of the following files (located in IntegrationServer/instances/default/config directory) is corrupted:

1. txnPassStore.dat
2. empw.dat
3. configPassman.cnf
4. passman.cnf

There should be backup copies of these files located in IntegrationServer/instances/default/config/backup.

Please make copies of the above files from the backup directory and copy them to the IntegrationServer/instances/default/config/ directory.

The restart the IS.

Best Regards,
Phani Vuyyuru

Commands to restore files :

xsu sag
cd /sag/IS_96/IntegrationServer/instances/default/config/
cp -p txnPassStore.dat txnPassStore.dat.corrupt
cp -p empw.dat empw.dat.corrupt
cp -p configPassman.cnf configPassman.cnf.corrupt
cp -p passman.cnf passman.cnf.corrupt

cd backup

cp txnPassStore.dat ..
cp empw.dat ..
cp configPassman.cnf ..
cp passman.cnf ..