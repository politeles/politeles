+++ 
draft = false
date = 2015-05-08T00:09:12+02:00
title = "Configure logging on C# project with Visual Studio"
description = ""
slug = "configure-logging-c-project-visual-studio" 
tags = []
categories = []
externalLink = ""
series = []
+++

In this post I'm going to talk about the configuration of two loggers for a <a href="https://www.visualstudio.com/en-us/downloads/download-visual-studio-vs.aspx" target="_blank">Visual Studio 2013 C# </a>project. I work with the free community edition. In this case we want one log for errors and another one for the actions that our program will be doing.

The first thing to do is to download and install the Apache log4net library. You can follow the instructions on the <a href="http://logging.apache.org/log4net/" target="_blank">project's page</a>.

There are three thing we have to do to configure the logger:
<ol>
	<li>Configure the logger on the application. Usually an XML file. </li>
	<li>Create the (singleton) classes for loggers</li>
	<li>Start logging in the application</li>


</ol>
So first things first. There are several ways to configure the logger in the application. Some people prefer the configuration of the logger in the application config file. Your project's .config file will look something like this:
 
<pre class="lang:xhtml decode:true " title="Application config file" >&lt;!-- &lt;log4net configSource="log4net.config" /&gt; --&gt;
  &lt;log4net&gt;
    &lt;appender name="FileAppender" type="log4net.Appender.FileAppender"&gt;
      &lt;file value="MyAppLog.log" /&gt;
      &lt;appendToFile value="true" /&gt;
      &lt;layout type="log4net.Layout.PatternLayout"&gt;
        &lt;conversionPattern value="%date [%thread] %-5level %logger [%property{NDC}] - %message%newline" /&gt;
      &lt;/layout&gt;
    &lt;/appender&gt;
    &lt;appender name="ConsoleAppender" type="log4net.Appender.ConsoleAppender" &gt;
      &lt;layout type="log4net.Layout.PatternLayout"&gt;
        &lt;param name="Header" value="[Header]\r\n" /&gt;
        &lt;param name="Footer" value="[Footer]\r\n" /&gt;
        &lt;param name="ConversionPattern" value="%date [%thread] %-5level %logger [%property{NDC}] - %message%newline" /&gt;
      &lt;/layout&gt;
    &lt;/appender&gt;
    &lt;appender name="RollingFileAppender" type="log4net.Appender.RollingFileAppender"&gt;
      &lt;file value="MyAppRollingLog.log" /&gt;
      &lt;appendToFile value="true" /&gt;
      &lt;rollingStyle value="Size" /&gt;
      &lt;maxSizeRollBackups value="10" /&gt;
      &lt;maximumFileSize value="1MB" /&gt;
      &lt;staticLogFileName value="true" /&gt;
      &lt;layout type="log4net.Layout.PatternLayout"&gt;
        &lt;conversionPattern value="%date [%thread] %level %logger - %message%newline" /&gt;
      &lt;/layout&gt;
    &lt;/appender&gt;
    &lt;root&gt;
      &lt;level value="ALL" /&gt;
      &lt;appender-ref ref="FileAppender" /&gt;
      &lt;appender-ref ref="ConsoleAppender"/&gt;
      &lt;appender-ref ref="RollingFileAppender"/&gt;
    &lt;/root&gt;
  &lt;/log4net&gt;</pre> 

In this sample configuration file there are configured three appenders, one for console and two for file output, the RollingFileAppender is configured to roll the log file every 1MB in a maximum of 10 extensions. I think a RollingFileAppender is the more appropriate thing for an error log in an application. Anyway I prefer the configuration of the logger in an XML file. The log4net offers the possibility to scan an XML configuration file and adapt the loggers based on that file. To do that, just write in your C# app:
 
<pre class="lang:c# mark:4 decode:true " title="Initialize the logger" >static void Main(string[] args)
        {
            try { 
            XmlConfigurator.ConfigureAndWatch(new System.IO.FileInfo("lognet_config.txt"));  
            }
            catch (Exception e)
            {
                // handle the exception here
            }
}</pre> 
The other thing to do is to create a singleton class for each logger you want to use. For instance, in my app I will use 2 loggers, and the C# class is something like:
 
<pre class="lang:c# decode:true " title="LoggerClass" >using log4net;
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
}</pre> 
 
Now we are ready to use the logger in our application, all that uses the Log logger will be written in an error log and all that uses ActionInfo log will be written to an action log.
So for instance you may have this code to convert a String value into an Int32 value:
 
<pre class="lang:c# mark:8,12 decode:true " title="Code example" > protected Int32 readIntValue(String field, Object val)
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
        }</pre> 
On line 8 we will write the output to the actionInfo logger (that will be written into a rolling logger file) and the errors to the Log file, that will be written into another rolling file.
Let's take a look at the final XML configuration file:
 
<pre class="lang:xhtml decode:true " >&lt;log4net&gt;
    &lt;appender name="Console" type="log4net.Appender.ConsoleAppender"&gt;
        &lt;layout type="log4net.Layout.PatternLayout"&gt;
            &lt;!-- Pattern to output the caller's file name and line number --&gt;
            &lt;conversionPattern value="%d %5level [%thread] (%file:%line) - %message%newline" /&gt;
        &lt;/layout&gt;
    &lt;/appender&gt;
    
    &lt;appender name="ErrorLog" type="log4net.Appender.RollingFileAppender"&gt;
        &lt;file value="error.log" /&gt;
        &lt;appendToFile value="true" /&gt;
        &lt;maximumFileSize value="100KB" /&gt;
        &lt;maxSizeRollBackups value="2" /&gt;

        &lt;layout type="log4net.Layout.PatternLayout"&gt;
            &lt;conversionPattern value="%d %level %thread %logger - %message%newline" /&gt;
        &lt;/layout&gt;
    &lt;/appender&gt;
	&lt;appender name="ActionInfo" type="log4net.Appender.RollingFileAppender"&gt;
        &lt;file value="actionInfo.log" /&gt;
        &lt;appendToFile value="true" /&gt;
        &lt;maximumFileSize value="1000KB" /&gt;
        &lt;maxSizeRollBackups value="2" /&gt;

        &lt;layout type="log4net.Layout.PatternLayout"&gt;
            &lt;conversionPattern value="%d %level %thread %logger - %message%newline" /&gt;
        &lt;/layout&gt;
    &lt;/appender&gt;
    &lt;logger additivity="false" name="ActionInfo"&gt;
    &lt;level value="INFO"/&gt;
    &lt;appender-ref ref="ActionInfo" /&gt;
  &lt;/logger&gt;
   &lt;logger additivity="false" name="ErrorLog"&gt;
    &lt;level value="DEBUG"/&gt;
    &lt;appender-ref ref="ErrorLog" /&gt;
  &lt;/logger&gt;
    &lt;root&gt;
        &lt;appender-ref ref="Console" /&gt;
        &lt;appender-ref ref="ErrorLog" /&gt;
		
    &lt;/root&gt;
&lt;/log4net&gt;</pre> 


