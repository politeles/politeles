' This scripts connects to EFT server and creates groups
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
eftSiteNames.Add "dev",Array("Customer-Reg","NGAHR-Reg")
eftSiteNames.Add "tst",Array("Customer-Reg","NGAHR-Reg")
eftSiteNames.Add "onb",Array("Customer-Reg","NGAHR-Reg")
eftSiteNames.Add "qas",Array("Customers-Test","NGAHR-Test")
eftSiteNames.Add "prd",Array("Customers-Prod","NGAHR-Prod")


' Change to F: on real systems
baseFolder = "C:/InetPub/EFTRoot/Customers-DEV/virtual"
Dim denvs
Set denvs = CreateObject("Scripting.Dictionary")

denvs.Add "onb","GR"
denvs.Add "tst","GR"
denvs.Add "dev","GR"
denvs.Add "qas","GT"
denvs.Add "prd","GP"

Dim groupNames
Set groupNames = CreateObject("Scripting.Dictionary")
' Automatically compose the group name from parameters:
groupName = denvs.Item(env) & "." & UCase(gcc) & "." & UCase(hris) & "." & UCase(itf)
groupNames.Add eftSiteNames.Item(env)(0),Array(groupName)
' On the internal site, we need two groups:
groupNameInt = denvs.Item(env) & "." & UCase(gcc) & ".R"
groupNameInt2 = denvs.Item(env) & "." & UCase(gcc) & ".RW"
groupNames.Add eftSiteNames.Item(env)(1),Array(groupNameInt,groupNameInt2)
'For Each siteName In sitesNames
'For Each i In groupNames.Item(siteName)
'  WScript.Echo "Groups names: " & i
'Next
'Next
If Not Connect(txtServer, txtPort, txtAdminUserName, txtPassword) Then
  WScript.Echo "Error connecting to EFT"
  WScript.Quit(-1)
End If
WScript.Echo "Connected to EFT ... "




WScript.Echo "Creating groups "
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
 For Each groupName In groupNames.Item(siteName)
 ' For each group, an error is raised when the folder is already created.
 On Error Resume Next
 call selectedSite.CreatePermissionGroup(groupName)
 If Err.Number <> 0 Then
  WScript.Echo "Error Creating permission group: " & groupName & " Error Description: "   & Err.Description
  Err.Clear
 End If 
 

 Next
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