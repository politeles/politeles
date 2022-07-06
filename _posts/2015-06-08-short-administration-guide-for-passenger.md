---
toc: true
layout: post
description: A quick guide on admin Phusion Passenger, a web sever for Ruby, Python and more!
categories: [server passenger linux sysadmin]
title:  Short Administration guide for passenger
---

Hi, I'm working on several projects with Phusion Passenger software.
The administration is not really well documented and also is not so powerful.

There are some tools to analyze the memory usage like passenger-memory-stats.
In my system the output is something like:
 
```shell
passenger-memory-stats
Version: 4.0.59
Date   : 2015-05-12 16:07:11 +0200
------------- Apache processes -------------
*** WARNING: The Apache executable cannot be found.
Please set the APXS2 environment variable to your 'apxs2' executable's filename,                                                              or set the HTTPD environment variable to your 'httpd' or 'apache2' executable's                                                              filename.


---------- Nginx processes ----------
PID    PPID   VMSize   Private  Name
-------------------------------------
20463  1      24.3 MB  ?        nginx: master process /usr/sbin/nginx -c /etc/ng                                                             inx/nginx.conf
26826  20463  30.5 MB  ?        nginx: worker process
### Processes: 2
### Total private dirty RSS: 0.00 MB (?)


------ Passenger processes -------
PID    VMSize     Private    Name
----------------------------------
12284  83.5 MB    0.3 MB     PassengerWatchdog
12287  117.9 MB   1.1 MB     PassengerHelperAgent
12292  26.7 MB    0.5 MB     PassengerLoggingAgent
12302  26.0 MB    0.2 MB     PassengerWebHelper: master process /home/project                                                            1/.passenger-enterprise/standalone/4.0.59/webhelper-1.6.2-x86_64-linux/Passenger                                                             WebHelper -c /tmp/passenger-standalone.1r1zr19/config -p /tmp/passenger-standalo                                                             ne.1r1zr19/

15170  26.4 MB    0.6 MB     PassengerWebHelper: worker process
16390  504.5 MB   230.2 MB   Passenger RackApp: /home/myproject/curren                                                      
16676  438.2 MB   260.4 MB   Passenger RackApp: /home/test/curren                                                            
                                                          
### Processes: 95
### Total private dirty RSS: 8074.19 MB
*** WARNING: Please run this tool with sudo. Otherwise the private dirty RSS (a                                                              reliable metric for real memory usage) of processes cannot be determined.
```

The other tool for the administration is passenger-status:

 
```shell
passenger-status
It appears that multiple Passenger instances are running. Please select a specific one by running:

  passenger-status <PID>

The following Passenger instances are running:
  PID: 12494
  PID: 14656
  PID: 12302
  PID: 15169
  PID: 13833
  PID: 15000
  PID: 13441
  PID: 12370
  PID: 12896
  PID: 12656
  PID: 14192
  PID: 14018
  PID: 13672
  PID: 13614
  PID: 14395
  PID: 12438
```
Once you select the passenger process, you can dig in deeper:

 
```shell
passenger-status 12494 --verbose
Version : 4.0.59
Date    : 2015-05-12 16:15:21 +0200
Instance: 12494
----------- General information -----------
Max pool size : 3
Processes     : 1
Requests in top-level queue : 0

----------- Application groups -----------
/homeproject/current#default:
  App root: /home/myproject/current
  Requests in queue: 0
  * PID: 17563   Sessions: 0       Processed: 30      Uptime: 4h 0m 31s
    CPU: 0%      Memory  : 235M    Last used: 19m 10s a
    URL     : http://127.0.0.1:53765
    Password: DTwE2g0zvvELqdDyviXrzi3FvNADc0PVc1l03TX084R

localhost:~&gt; curl -H "X-Passenger-Connect-Password: DTwE2g0zvvELqdDyviXrzi3FvNADc0PVc1l03TX084R" http://127.0.0.1:53765
```

you can connect to the administration console, via curl. If you don't get any answer, that means that your server is frozen. If you want to see a trace in the logs, you need to kill it sending one of those signals: SIGQUIT, SIGTERM.

You can find more information about this on the following sites:


https://www.phusionpassenger.com/documentation/Users%20guide%20Apache.html: On Point 9: 9. Analysis and system maintenance

[URL scheme](http://en.wikipedia.org/wiki/URI_scheme)

[Passenger optimization guide:](https://www.phusionpassenger.com/documentation/ServerOptimizationGuide.html)

