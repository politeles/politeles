---
toc: true
layout: post
description: Configuration of Visual Studio Logging for a C# project
categories: [windows visualStudio C#]
title:  Configure logging on C# project with Visual Studio
---

In this post I'm going to talk about the configuration of two loggers for [Visual Studio 2013 C# project](https://www.visualstudio.com/en-us/downloads/download-visual-studio-vs.aspx). I work with the free community edition. In this case we want one log for errors and another one for the actions that our program will be doing.

The first thing to do is to download and install the Apache log4net library. You can follow the instructions on the [Apache project's page](http://logging.apache.org/log4net/).

There are three thing we have to do to configure the logger:
 - Configure the logger on the application. Usually an XML file.
 - Create the (singleton) classes for loggers.
 - Start logging in the application.

First things first. There are several ways to configure the logger in the application. Some people prefer the configuration of the logger in the application config file. Your project's .config file will look something like this:
 
```xml
<!-- <log4net configSource="log4net.config" /> -->
  <log4net>
    <appender name="FileAppender" type="log4net.Appender.FileAppender">
      <file value="MyAppLog.log" />
      <appendToFile value="true" />
      <layout type="log4net.Layout.PatternLayout">
        <conversionPattern value="%date [%thread] %-5level %logger [%property{NDC}] - %message%newline" />
      </layout>
    </appender>
    <appender name="ConsoleAppender" type="log4net.Appender.ConsoleAppender" >
      <layout type="log4net.Layout.PatternLayout">
        <param name="Header" value="[Header]\r\n" />
        <param name="Footer" value="[Footer]\r\n" />
        <param name="ConversionPattern" value="%date [%thread] %-5level %logger [%property{NDC}] - %message%newline" />
      </layout>
    </appender>
    <appender name="RollingFileAppender" type="log4net.Appender.RollingFileAppender">
      <file value="MyAppRollingLog.log" />
      <appendToFile value="true" />
      <rollingStyle value="Size" />
      <maxSizeRollBackups value="10" />
      <maximumFileSize value="1MB" />
      <staticLogFileName value="true" />
      <layout type="log4net.Layout.PatternLayout">
        <conversionPattern value="%date [%thread] %level %logger - %message%newline" />
      </layout>
    </appender>
    <root>
      <level value="ALL" />
      <appender-ref ref="FileAppender" />
      <appender-ref ref="ConsoleAppender"/>
      <appender-ref ref="RollingFileAppender"/>
    </root>
  </log4net>
```

In this sample configuration file there are configured three appenders, one for console and two for file output, the RollingFileAppender is configured to roll the log file every 1MB in a maximum of 10 extensions. I think a RollingFileAppender is the more appropriate thing for an error log in an application. Anyway I prefer the configuration of the logger in an XML file. The log4net offers the possibility to scan an XML configuration file and adapt the loggers based on that file. To do that, just write in your C# app:
 
```c#
static void Main(string[] args)
        {
            try { 
            XmlConfigurator.ConfigureAndWatch(new System.IO.FileInfo("lognet_config.txt"));  
            }
            catch (Exception e)
            {
                // handle the exception here
            }
}
```
 
The other thing to do is to create a singleton class for each logger you want to use. For instance, in my app I will use 2 loggers, and the C# class is something like:
 
```c#
using log4net;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace MyApp.utils
{
    class Logger
    {
        public static readonly ILog Log = LogManager.GetLogger("ErrorLog");
        public static readonly ILog ActionInfo = LogManager.GetLogger("ActionInfo");
    }
}
``` 
 
Now we are ready to use the logger in our application, all that uses the Log logger will be written in an error log and all that uses ActionInfo log will be written to an action log.
So for instance you may have this code to convert a String value into an Int32 value:
 
```c#
protected Int32 readIntValue(String field, Object val)
        {
            Int32 res = new Int32();
            try
            {
                String str = val.ToString();
                if (str.CompareTo("") != 0) res = Convert.ToInt32(str);
MyApp.utils.ActionInfo.Info("Field Parsed");
            }
            catch (Exception)
            {
                MyApp.utils.Logger.Log.Debug("Error converting field:" + field);

            }
            return res;
        }
```

On line 8 we will write the output to the actionInfo logger (that will be written into a rolling logger file) and the errors to the Log file, that will be written into another rolling file.
Let's take a look at the final XML configuration file:
 
```xml
<log4net>
    <appender name="Console" type="log4net.Appender.ConsoleAppender">
        <layout type="log4net.Layout.PatternLayout">
            <!-- Pattern to output the caller's file name and line number -->
            <conversionPattern value="%d %5level [%thread] (%file:%line) - %message%newline" />
        </layout>
    </appender>
    
    <appender name="ErrorLog" type="log4net.Appender.RollingFileAppender">
        <file value="error.log" />
        <appendToFile value="true" />
        <maximumFileSize value="100KB" />
        <maxSizeRollBackups value="2" />

        <layout type="log4net.Layout.PatternLayout">
            <conversionPattern value="%d %level %thread %logger - %message%newline" />
        </layout>
    </appender>
	<appender name="ActionInfo" type="log4net.Appender.RollingFileAppender">
        <file value="actionInfo.log" />
        <appendToFile value="true" />
        <maximumFileSize value="1000KB" />
        <maxSizeRollBackups value="2" />

        <layout type="log4net.Layout.PatternLayout">
            <conversionPattern value="%d %level %thread %logger - %message%newline" />
        </layout>
    </appender>
    <logger additivity="false" name="ActionInfo">
    <level value="INFO"/>
    <appender-ref ref="ActionInfo" />
  </logger>
   <logger additivity="false" name="ErrorLog">
    <level value="DEBUG"/>
    <appender-ref ref="ErrorLog" />
  </logger>
    <root>
        <appender-ref ref="Console" />
        <appender-ref ref="ErrorLog" />
		
    </root>
</log4net>
```

