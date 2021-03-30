+++ 
draft = false
date = 2015-05-07T00:09:12+02:00
title = "Create folder structures"
description = ""
slug = "" 
tags = ['os']
categories = ['windows']
externalLink = ""
series = []
+++


# Automate folder creation on Windows


How to automate folder creation and folders structure creation on windows:

```
@ECHO OFF
REM Create folders for a new interface
REM Parameters: GCC HRIS ITFT

set basefolder=f:\interfaces
set folders=(in out reports staging archive)

set argC=0
for %%x in (%*) do Set /A argC+=1

:parametercheck
if -%argC%- lss 3 (
goto :wrongcall
)

echo Creating folder interfaces:

:folderloop
for %%i in %folders% do (
echo  mkdir %basefolder%\%1\%2\%3\%%i
mkdir %basefolder%\%1\%2\%3\%%i
)
goto :end

REM echo f:\interfaces\%1\%2\%3\in
REM mkdir  f:\interfaces\%1\%2\%3\in
REM mkdir 

:wrongcall

echo Wrong call.
echo %0 GCC HRIS ITFTxx
echo Where
echo GCC: Global Customer Name
echo HRIS: third party name
echo ITFTxx interface number. Example: itft01
echo sample usage:
echo %0 abv sfsf itfq01

:end
```







