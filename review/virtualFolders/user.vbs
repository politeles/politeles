' This scripts connects to EFT server and configure an existing user.
' Please note that the user have to exist on the LDAP domain: USER.ARINSO
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
' cscript.exe user.vbs env gcc hris itft01 username
' TODO: Check first if groups exists, to avoid error
Set SFTPServer = WScript.CreateObject("SFTPCOMInterface.CIServer")
' Get arguments from command line:
Set args = Wscript.Arguments
CheckParameters(args)
env = args(0)
gcc = args(1)
hris= args(2)
itf = args(3)
username= args(4)


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




WScript.Echo "Configuring user ... "
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

 On Error Resume Next
Set userSettings = selectedSite.GetUserSettings(username)
selectedSite.MoveUserToSettingsLevel username, "Internet-SFTP-FTPS-" & UCase(Left(env,1)) & Mid(env,2)
' according to: http://help.globalscape.com/help/gs_com_api/COM_Difference_between_VARIANT_BOOL_and_SFTPAdvBool.htm?rhsearch=SFTPAdvBool.abTrue
' 1 - True
userSettings.setEnableAccount(1)
userSettings.SetHomeDir(1)
homeFolder = "/interfaces/" & gcc & "/" & hris & "/" & itf
WScript.Echo "Home Folder" & homeFolder
userSettings.SetHomeDirString(homeFolder)
userSettings.SetEnableDiskQuota(1)
' 400 MB initial quota
userSettings.SetMaxSpace(400 * 1024)
userSettings.SetFTPS(1)
userSettings.SetSFTP(1)
' Note that HTTP is not enabled due to licensing cost on EFT on version 7.3
' name of the permission group: 
groupName = denvs.Item(env) & "." & UCase(gcc) & "." & UCase(hris) & "." & UCase(itf)
selectedSite.AddUserToPermissionGroup userName, groupName
Next








' Close the connection
SFTPServer.Close
Set SFTPServer = nothing
WScript.Quit(0)



Function CheckParameters(args)

  
 If args.Count <> 5 Then
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