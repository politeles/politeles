' This scripts connects to EFT server and create a monitor folder rule
' The typical naming convention is:
' On Customers Sites:
' GX.GCC.HRIS.ITFN
' Where 
' GX = Depending on the environment it could be: 
' GR (regression environment) For dev, test, onboarding interfaces
' GT (test environment) For qas interfaces
' GP (Production environment) for production interfaces
' GCC = Global customer code
' HRIS = Third Party
' ITFN = Interface name
' On the internal site, there are always 2 groups: GX.GCC.R and GX.GCC.RW
' How to run it:
' cscript.exe groups.vbs env gcc hris itft01 
' TODO: Check first if groups exists, to avoid error
Set SFTPServer = WScript.CreateObject("SFTPCOMInterface.CIServer")
' Get arguments from command line:
Set args = Wscript.Arguments
CheckParameters(args)
env = args(0)
gcc = args(1)
hris= args(2)
itf = args(3)

txtServer = "localhost"
txtPort =  "1100"
txtAdminUserName = "admin"
txtPassword = "Arinso01"
'sitesNames = Array("Customers","NGAHR")
'compose site names
Dim eftSiteNames
Set eftSiteNames = CreateObject("Scripting.Dictionary")
' Note that event rules are created only on Customer sites
eftSiteNames.Add "dev",Array("Customer-Reg")
eftSiteNames.Add "tst",Array("Customer-Reg")
eftSiteNames.Add "onb",Array("Customer-Reg")
eftSiteNames.Add "qas",Array("Customers-Test")
eftSiteNames.Add "prd",Array("Customers-Prod")


' Change to F: on real systems
baseFolder = "C:/InetPub/EFTRoot/Customer-Reg/virtual"
Dim denvs
Set denvs = CreateObject("Scripting.Dictionary")

denvs.Add "onb","GR"
denvs.Add "tst","GR"
denvs.Add "dev","GR"
denvs.Add "qas","GT"
denvs.Add "prd","GP"


If Not Connect(txtServer, txtPort, txtAdminUserName, txtPassword) Then
  WScript.Echo "Error connecting to EFT"
  WScript.Quit(-1)
End If
WScript.Echo "Connected to EFT ... "




WScript.Echo "Creating rule "
' Get sites:
set sites = SFTPServer.Sites()

' For each site
For Each siteName In eftSiteNames.Item(env)
 For i = 0 To sites.Count -1
  set site = sites.Item(i)
  If site.Name = siteName Then
  set selectedSite = site
  Exit For
  End If
 Next

 WScript.Echo "Site: " & siteName
'EventType:
'OnTimer = 4097,
'OnLogRotate = 4098,
'OnServiceStopped = 4099,
'OnServiceStarted = 4100,
'MonitorFolder = 4101,
'OnMonitorFolderFailed = 4102,
'OnSiteStarted = 8193,
'OnSiteStopped = 8194,
'OnIPAddedToBanList = 8195,
'OnClientConnected = 12289,
'OnClientConnectionFailed = 12290,
'OnClientDisconnected = 12291,
'OnClientDisabled = 16385,
'OnClientQuotaExceeded = 16386,
'OnClientLoggedOut = 16387,
'OnClientLoggedIn = 16388,
'OnClientLoginFailed = 16389,
'OnClientPasswordChanged = 16390,
'OnClientCreated = 16391,
'OnClientLocked = 16392,
'OnFileDeleted = 20481,
'OnFileUpload = 20482,
'BeforeFileDownload = 20483,
'OnFileDownload = 20484,
'OnFileRenamed = 20485,
'OnFolderCreated = 20486,
'OnFolderDeleted = 20487,
'OnUploadFailed = 20489,
'OnDownloadFailed = 20490,
'OnChangeFolder = 20491,
'OnFileMoved = 20492,
'OnVerifiedUploadSuccess = 20493,
'OnVerifiedUploadFailure = 20494,
'OnVerifiedDownloadSuccess = 20495,
'OnVerifiedDownloadFailure = 20496,
'AS2InboundTransactionSucceeded = 24577,
'AS2InboundTransactionFailed = 24578,
'AS2OutboundTransactionSucceeded = 24579,
'AS2OutboundTransactionFailed = 24580,

' We will create rule Monitor Folder
 ' For each group, an error is raised when the folder is already created.
 On Error Resume Next
Set rules = selectedSite.EventRules(4101)
' Set Parameters:
WScript.Echo "Number of event rules: " & rules.Count()
Set objParams = WScript.CreateObject("SFTPCOMInterface.CIFolderMonitorEventRuleParams")
If Err.Number <> 0 Then
  WScript.Echo "Error Creating rule. Error No. " & Err.Number & " Error Description: "   & Err.Description
  Err.Clear
 End If 

 objParams.CheckHealthInterval = 10
 objParams.CheckHealth = True
 objParams.PollInterval = 5
 
 'This sets the poll interval type in minutes
 objParams.PollIntervalType = 1
 objParams.UsePeriodicDirectoryPoll = True
 'Rule name: /gcc/hris/itfxx_inbound_folder_monitor
 objParams.Name = "/" & gcc & "/" & hris & "/" & itf & "_inbound_folder_monitor"
 WScript.Echo objParams.Name
 objParams.Enabled = True
 objParams.Description = "Created by EFT Script. Developers contact: joseenrique.pons@ngahr.com , eric.frankx@ngahr.com"
 folder = baseFolder &"/interfaces/" & gcc & "/" & hris & "/" & itf & "/in"
 Wscript.Echo "real folder: " & folder
 objParams.Path = folder

 Set eventRule = rules.Add(rules.Count(), objParams) 
If Err.Number <> 0 Then
  WScript.Echo "Error Creating rule.Step 2 Error No. " & Err.Number & " Error Description: "   & Err.Description
  Err.Clear
 End If 

 ' Now add the AWE script and set the rule parameters:
 ' according to: http://help.globalscape.com/help/gs_com_api/COM_Enum_Reference.htm#EventProperty
 ' FolderOperation = 5008; STRING; File Change
 ' ConditionOperation: http://help.globalscape.com/help/gs_com_api/COM_Enum_Reference.htm#ConditionOperator
 ' Value 1 = Equals
 Set ifStatement =  eventRule.AddIfStatement(0, "5008", 1, "added", False)
 Set aStatement = ifStatement.IfSection
 Set AWTaskParams = CreateObject("SFTPCOMInterface.CIAWTaskActionParams")
 ' AWS script name
 rule_version = "ZINBOUND_FU_v.1.22"
 AWTaskParams.TaskName = rule_version
 call AWTaskParams.AddVariable("Z_CUSTOMERID",gcc)
 call AWTaskParams.AddVariable("Z_PARTNERID",hris)
 call AWTaskParams.AddVariable("Z_ITFN",itf)
 call AWTaskParams.AddVariable("Z_FU_FILENAME","%FS.FILE_NAME%")
 call AWTaskParams.AddVariable("Z_BE_DESTINATION",env & "esbftps2s.ngahr.com")
 call AWTaskParams.AddVariable("Z_BE_USERID","pex_" & env & "_" & gcc )
 call AWTaskParams.AddVariable("Z_BE_TARGETPATH",  folder)
 call AWTaskParams.AddVariable("Z_TO_NOTIFY_WS_HOST","https://" & env & "esbs2s.ngahr.com/invoke/nga.atlas.IncomingBatchFile.filePolling:process")
 call AWTaskParams.AddVariable("Z_TO_PING_URL","https://" & env & "esbs2s.ngahr.com/invoke/nga.atlas.monitoring.services:keepAlive_esb")
 call AWTaskParams.AddVariable("Z_NOTIFY_PATH_PREFIX","/interfaces/" & gcc)
 call AWTaskParams.AddVariable("Z_TMP_FILEMASK",".tmp")



 call aStatement.Add(aStatement.Count(),AWTaskParams)
 If Err.Number <> 0 Then
  WScript.Echo "Error Creating rule.Step 3.Error No. " & Err.Number & " Error Description: "   & Err.Description
  Err.Clear
 End If 

 
Next








' Close the connection
SFTPServer.Close
Set SFTPServer = nothing
WScript.Quit(0)



Function CheckParameters(args)

  
 If args.Count <> 4 Then
  WScript.Echo "Wrong number of parameters. "
  WScript.Echo "Correct call: "
  WScript.Echo args(0) & "env  gcc hris itfn"
  WScript.Echo "Where env is the environment: dev | tst | onb | qas | prd "
  WScript.Echo "gcc is the global customer code" 
  WScript.Echo "hris is the partner id "
  WScript.Echo "itfn is the interface number"
  WScript.Quit(-1)
  Exit Function
 End If


End Function

' Function that connects to EFT
' serverOrIpAddress: EFT host
' port: EFT admin port (default: 1100)
' username: admin username
' password: admin password
' Note: do not forget to close the connection:
' SFTPServer.Close
' Set SFTPServer = nothing
'
Function Connect (serverOrIpAddress, port, username, password)

  On Error Resume Next
  Err.Clear

  SFTPServer.Connect serverOrIpAddress, port, username, password

  If Err.Number <> 0 Then
    WScript.Echo "Error connecting to '" & serverOrIpAddress & ":" &  port & "' -- " & err.Description & " [" & CStr(err.Number) & "]", vbInformation, "Error"
    Connect = False
    Exit Function
  End If

  Connect = True
End Function