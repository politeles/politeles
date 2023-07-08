---
aliases:
- /2015/05/07/how-to-automate-folder-creation-and-folders-structure-creation-on-windows
categories:
- windows 
- cli
- folder
date: '2015-05-07'
description: Practical example using the script to automate folder creation
layout: post
title: How to automate folder creation in windows
toc: true

---

In this post I'm going to show some script files using the old batch scripting style that works perfectly on windows 7 an on. You will find very good books and reviews on the internet like [Windows_Batch_Scripting](http://en.wikibooks.org/wiki/Windows_Batch_Scripting).

In my case we need to automate the creation of the following folder structure:
 - Main Folder
  -  Sub Folder
   -  Sub Sub Folder
    - Folder 1
    - Folder 2
    - Folder 3
    - Folder n

So I developed the following a small batch script to create interfaces. First I check the arguments and set some initial variables, like the starting folder and so.

```bash
@ECHO OFF
REM Create folders for a new interface
REM Parameters: Folder SubFolder SubSubfolder

set basefolder=c:\
set folders=(folder1 folder2 folder3 foldern)

set argC=0
for %%x in (%*) do Set /A argC+=1

:parametercheck
if -%argC%- lss 3 (
goto :wrongcall
)
```

The script loops on the folders variable and create the structure:

```bash
echo Creating folder interfaces:

:folderloop
for %%i in %folders% do (
echo  mkdir %basefolder%\%1\%2\%3\%%i
mkdir %basefolder%\%1\%2\%3\%%i
)
goto :end
```

Finally I handle wrong calls with the following code:

```bash
:wrongcall

echo Wrong call.
echo %0 Folder SubFolder SubSubFolder
echo Where
echo Folder : Is the main folder
echo SubFolder : Is the secondary folder
echo SubSubFolder Is the SubSubFolder
echo sample usage:
echo %0 folder1 sfmt int12
```

I automated the creation of folders with a call from an external batch file, so I can create multiple folders:
 
```bash
@ECHO OFF
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
:end
```

Where *new_itf.bat* is the name I gave to the other batch file. 
The aspect of the configuration file is quite simple:

```ini
Folder SubFolder SubSubFolder1
Folder SubFolder SubSubFolder2
Folder SubFolder SubSubFolder3
Folder SubFolder SubSubFolder4
```
