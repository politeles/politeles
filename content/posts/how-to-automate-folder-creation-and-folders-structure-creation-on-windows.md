+++ 
draft = false
date = 2015-05-07T00:09:12+02:00
title = "How to automate folder creation and folders' structure creation on windows"
description = ""
slug = "how-to-automate-folder-creation-and-folders-structure-creation-on-windows" 
tags = []
categories = []
externalLink = ""
series = []
+++

In this post I'm going to show some script files using the old batch scripting style that works perfectly on windows 7 an on. You will find very good books and reviews on the internet like<a href="http://en.wikibooks.org/wiki/Windows_Batch_Scripting" target="_blank">Windows_Batch_Scripting</a>.

In my case we need to automate the creation of the following folder structure:
<ul>
	<li>Main Folder
<ul>
	<li>Sub Folder
<ul>
	<li>Sub Sub Folder
<ul>
	<li>Folder 1</li>
	<li>Folder 2</li>
	<li>Folder 3</li>
	<li>Folder n</li>
</ul>
</li>
</ul>
</li>
</ul>
</li>
</ul>
So I developed the following a small batch script to create interfaces. First I check the arguments and set some initial variables, like the starting folder and so.
<pre class="lang:batch decode:true " title="Script start">@ECHO OFF
REM Create folders for a new interface
REM Parameters: Folder SubFolder SubSubfolder

set basefolder=c:\
set folders=(folder1 folder2 folder3 foldern)

set argC=0
for %%x in (%*) do Set /A argC+=1

:parametercheck
if -%argC%- lss 3 (
goto :wrongcall
)</pre>
The script loops on the folders variable and create the structure:
<pre class="lang:batch decode:true " title="Loop">echo Creating folder interfaces:

:folderloop
for %%i in %folders% do (
echo  mkdir %basefolder%\%1\%2\%3\%%i
mkdir %basefolder%\%1\%2\%3\%%i
)
goto :end</pre>
Finally I handle wrong calls with the following code:
<pre class="lang:batch decode:true" title="Wrong call handling">:wrongcall

echo Wrong call.
echo %0 Folder SubFolder SubSubFolder
echo Where
echo Folder : Is the main folder
echo SubFolder : Is the secondary folder
echo SubSubFolder Is the SubSubFolder
echo sample usage:
echo %0 folder1 sfmt int12</pre>

Finally I automated the creation of folders with a call from an external batch file, so I can create multiple folders:
 
<pre class="lang:batch mark:6,11 decode:true " title="Main Script" >@ECHO OFF
REM Create folders sets

set argC=0
for %%x in (%*) do Set /A argC+=1
:parametercheck
if -%argC%- lss 1 (
goto :wrongcall
)

for /F "tokens=*" %%A in (%1) do CALL new_itf.bat %%A

goto :end

:wrongcall

echo Wrong call.
echo %0 config_file
echo Where
echo config_file: configuration file
echo sample usage:
echo %0 folders.txt
:end</pre> 
Where new_itf.bat is the name I gave to the other batch file. 
The aspect of the configuration file is quite simple:

 
<pre class="theme:dark-terminal lang:sh decode:true " title="Configuration file" >Folder SubFolder SubSubFolder1
Folder SubFolder SubSubFolder2
Folder SubFolder SubSubFolder3
Folder SubFolder SubSubFolder4</pre> 
