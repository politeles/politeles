+++ 
draft = false
date = 2015-06-08T00:09:12+02:00
title = "interface check C#"
description = ""
slug = "" 
tags = ['C#']
categories = ['interfaces']
externalLink = ""
series = []
+++


#A small script to check interfaces on C#


```
To reject certificate check:
<system.net>
    <settings>
      <servicePointManager
          checkCertificateName="false"
          checkCertificateRevocationList="false"         
      />
    </settings>
  </system.net>
```

In the application config file.

Some useful links:
Check if a file exists:
https://msdn.microsoft.com/es-es/library/system.io.file.exists%28v=vs.110%29.aspx

How to write to a text file:
https://msdn.microsoft.com/es-es/library/8bh11f1k.aspx

How to download files from FTP:
https://msdn.microsoft.com/es-es/library/ms229711(v=vs.110).aspx

How to sleep a thread:
https://msdn.microsoft.com/es-es/library/d00bd51t(v=vs.110).aspx

Problems related to FTP with SSL:
Ignore SSL validation for certificates:
http://stackoverflow.com/questions/12506575/how-to-ignore-the-certificate-check-when-ssl

Configure FTP over SSL
http://stackoverflow.com/questions/1355341/ftp-over-ssl-for-c-sharp

Ignore web certificates:
http://weblog.west-wind.com/posts/2011/Feb/11/HttpWebRequest-and-Ignoring-SSL-Certificate-Errors

Library for FTPs on C#
http://netftp.codeplex.com/

Enabling SSL on c#
https://msdn.microsoft.com/en-us/library/system.net.ftpwebrequest.enablessl.aspx

Microsoft forums, How to accept SSL certificate of FTPS server.
https://social.msdn.microsoft.com/Forums/en-US/56a10641-4504-4f8b-8434-86156f8104be/how-to-accept-ssl-certificate-of-ftps-server?forum=netfxnetcom



