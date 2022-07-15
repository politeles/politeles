---
toc: true
layout: post
description: A ready to use script to convert all your heic images from your phone.
categories: [gcp firebase algolia]
title: Convert Heic files to JPG in windows
---

# Convert Heic files to JPG in windows

Heic format is a proprietary format for images. We can convert it in windows using [Gimp software](https://www.gimp.org/) and some batch scripting.
Once you installed Gimp, you can use the following batch script on windows to convert all images into jpg.

```batch
@echo off


REM Find Gimp in the registry
for /f "tokens=2*" %%a in ('reg query "HKCR\GIMP2.svg\shell\open\command" /ve 2^>^&1^|find "REG_"') do @set gimp=%%b

REM Calculate console exe
set gimp=%gimp:gimp-=gimp-console-%

REM Isolate exe
for %%i in (%gimp%) do (
    @set gimp=%%i
    goto :found
)

:found
echo Found Gimp console: %gimp%

REM Process files (change to "for /r %%i" for recursion)
for %%i in (*.heic) do (
    echo - Converting [ %%i --^> %%~ni.jpg] 
    %gimp% -i -b "(let* ((image (car (file-heif-load RUN-NONINTERACTIVE \"%%i\" \"\" ))) (drawable (car (gimp-image-get-active-layer image)))) (plug-in-autocrop RUN-NONINTERACTIVE image drawable) (gimp-file-save RUN-NONINTERACTIVE image drawable \"%%~ni.jpg\" \"%%~ni.jpg\") (gimp-image-delete image))" -b "(gimp-quit 0)"
)

```

I just modified the function called to load the heic files. Save this as a .bat file and it will transform all your heic files into jpg.

More information in the following sites:

[SuperUser](https://superuser.com/questions/77429/using-gimp-to-batch-convert-images-to-another-format-in-windows)
[Gimp manual](https://www.gimp.org/tutorials/Basic_Batch/)

![]({{site.baseurl}}/images/2022-07-15-heic.gif )