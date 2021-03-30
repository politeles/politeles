' This scripts connects to EFT server and creates virtual folders.
' The typical configuration is:
' GCC - EFT physical folder
' HRIS - EFT physical folder
' itf - EFT physical folder
' in - EFT virtual folder (this folder is the only one on Customers-DEV)
' archive - EFT virtual (only for NGAHR site)
' reports - EFT virtual (only for NGAHR site)
' How to run it:
' cscript.exe vfs.vbs gcc hris itft01 
' TODO: CHeck first if folders exists to avoid error 
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

Dim eftSiteNames
Set eftSiteNames = CreateObject("Scripting.Dictionary")
eftSiteNames.Add "dev",Array("Customer-Reg","NGAHR-Reg")
eftSiteNames.Add "tst",Array("Customer-Reg","NGAHR-Reg")
eftSiteNames.Add "onb",Array("Customer-Reg","NGAHR-Reg")
eftSiteNames.Add "qas",Array("Customers-Test","NGAHR-Test")
eftSiteNames.Add "prd",Array("Customers-Prod","NGAHR-Prod")
' Dictionary for environments
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

' Change to F: on real systems
baseFolder = "C:/InetPub/EFTRoot/Customer-Reg/virtual"
Dim dictFolders
Set dictFolders = CreateObject("Scripting.Dictionary")

dictFolders.Add eftSiteNames.Item(env)(0),Array("in")
dictFolders.Add eftSiteNames.Item(env)(1),Array("in","archive","reports")


If Not Connect(txtServer, txtPort, txtAdminUserName, txtPassword) Then
  WScript.Quit(-1)
End If
WScript.Echo "Connected to EFT ... "



WScript.Echo "GCC: " & gcc & " HRIS " & hris & " itf " & itf

' Get sites:
set sites = SFTPServer.Sites()
' folder name: 
folder = "/interfaces/" & gcc & "/" & hris & "/" & itf & "/"
' For each site, create physical folders.


For Each siteName In eftSiteNames.Item(env)
 For i = 0 To sites.Count -1
  set site = sites.Item(i)
  If site.Name = siteName Then
  set selectedSite = site
  Exit For
  End If
 Next
 WScript.Echo "Site: " & siteName
 ' For each folder, an error is raised when the folder is already created.
 On Error Resume Next
 call selectedSite.CreatePhysicalFolder(folder)
 If Err.Number <> 0 Then
  WScript.Echo "Error in VirtualFolder: " & Err.Description
  Err.Clear
 End If 
'Assign the group(s) to the given folder'
WScript.Echo "assigning group: " & groupName & " to folder: " & folder
For Each groupName in groupNames.Item(siteName)
  Set p = selectedSite.GetBlankPermission(folder,groupName)
  If Err.Number <> 0 Then
   WScript.Echo "Error Getting permission group: " & Err.Description
   Err.Clear
  End If 
  p.FileUpload = True
  p.FileDownload = True
  p.FileDelete = True
  p.FileRename = True
  p.FileAppend = True
  p.DirDelete = False
  p.DirCreate = False
  p.DirShowHidden = False
  p.DirShowReadOnly = False
  p.DirShowInList = True
  p.DirList = True
  selectedSite.SetPermission(p)
  If Err.Number <> 0 Then
   WScript.Echo "Error assigning permission group: " & Err.Description
   Err.Clear
  End If 
Next


 WScript.Echo "Site: " & siteName &" creating physical folder: " & folder 
 ' Creation of virtual folders
 vf = dictFolders.Item(siteName)
 WScript.Echo Join(vf)
 For Each f in vf
  virtualPath = folder & f
  realPath = baseFolder  & folder & f
  WScript.Echo " Site: " & siteName &" creating virtual folder: " & virtualPath & " realPath: " & realPath 
  call selectedSite.CreateVirtualFolder(virtualPath,realPath)
  If Err.Number <> 0 Then
  WScript.Echo "Error in VirtualFolder: " & Err.Description
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