# SAP Transport hang
1.0 Basic transport troubleshooting. Verify that there are no errors in system log.
1.1 Execute transaction STMS
1.2 Select Import Overview
1.3 Select SID
1.4 From menu > Go To > System Log
1.5 Correct if no issues in log.

1.5.1.1 Known Issue 1 - WARNING: \\SERVER\sapmnt\SIDtrans\tmp\SID.LOB is already in use
(22720), I'm waiting 2 sec (20100322091720). My name: pid 10128 on
SERVER (SIDadm)
1.5.1.2 Solution 1 - Backup and delete the file '\\SERVER\sapmnt\SIDtrans\tmp\SID.LOB'. Add the transport again and perform import.

1.5.2.1 Known issue 2 - Cannot find \\SERVER\sapmnt\SIDtrans\log\SLOGXX02.SID
1.5.2.2 Solution 2 - Make sure that file exists. If not, copy the most recent SLOG (example SLOGXX01) and rename it to SLOGXX02.SID. Check again the system log if the issue persist. 

1.5.3.1 Known issue 3 - Problems with job RDDIMPDP
1.5.3.2 Solution 3 - Execute SE38 > Run program RDDNEWPP > Choose Normal priority. This will schedule new RDDIMPDP job that is responsible for pushing transport requests in your system.

Disclaimer: The next steps are steps to clear the transport list to make sure that transports push successfully. This should be aligned with customer.

2.0 Clear the transport list and redo the transport
2.1 Execute transaction STMS
2.2 Import overview -> Goto -> Import monitor >
2.3 'Monitor' -> right click on transport -> delete entry
2.4 Redo the transport action. Proceed to next step if not solved.

3.0 Clear the transport tables
3.1 Make sure that there are no stuck transports in your transport tables.
3.2 Check and delete entries (using transaction SM30) any entries found in the following tables:

TPSTAT
TRJOB
TRBAT

3.3 To do this execute SM30 
3.4 Enter 'TRBAT' in Table/View.
3.5 Click on Display
3.6 Verify that NO transport number or HEADER exists.

3.7 If the Import Monitor or table TPSTAT does not contain
3.8 entries any more, you can delete the entries of tables TMSTLOCKR andTMSTLOCKP. 
3.9 Redo the transport action.

If this does not solve the problem. You have the option to stop all transport from OS level.

4.0 Kill tp.exe OS process
4.1 Login to SAP server
4.2 Kill any TP.exe processes at the OS level. 
4.3 Try again to add and import your request
4.4 Redo the transport action

5.0 Save transport resources.
5.1 It is SAP's recommendation that imports be done asynchrounously rather than synchronously. By doing this you will be conserving system Resources.
5.2 In doing the import > Execution tab > Select 'Asynchrounously' > Confirm import

Below is unlikely but could also apply.

6.0 Make sure that transport parameters are okay.
6.1 Add the following parameter to your transport profile.

'/system_pf=/usr/sap//SYS/profile/DEFAULT.PFL'

This parameter simply tells sapevt where to look for your DEFAULT.PFL. Check note 449270 for further information on this. Ensure you have the other settings like:

rdisp/mshost = 
rdisp/msserv = sapms
SAPSYSTEM = 00 (this is the system number)

Add system_pf paramter to transport tool via STMS. On the left have
system_pf and on the right /usr/sap//SYS/profile/DEFAULT.PFL

After this, restart the system so that the new parameter is taken into account by the system.