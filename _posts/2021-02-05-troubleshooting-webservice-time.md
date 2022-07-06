---
toc: true
layout: post
description: A quick guide on how to troubleshoot webservice time
categories: [linux webservice]
title:  Troubleshooting webservice time
---

# Troubleshooting webservice at OS level
We are trying to troubleshoot a webservice call that's taking a lot of time. The initial idea it that the processing time in our platform is the issue. Let's use [curl at OS level with the configuration as explained here](https://jpons.es/2021/03/how-to-get-times-from-curl/) to troubleshoot.

This is the answer we get from the curl command:

```json
{
"time_redirect": 0.000,
"time_namelookup": 5.515,
"time_connect": 5.630,
"time_appconnect": 6.008,
"time_pretransfer": 6.008,
"time_starttransfer": 6.385,
"time_total": 6.385,
"size_request": 375,
"size_upload": 103,
"size_download": 375,
"size_header": 343
}
```


Here we see 5+ seconds in the name resolution. A first workaround is to get the IP address of the target and bypass the name server by using the hostname file:

```shell
nslookup webexapis.com
```

we will get several answers:

```json
Server:		100.125.4.25
Address:	100.125.4.25#53

Non-authoritative answer:
Name:	webexapis.com
Address: 3.130.32.130
Name:	webexapis.com
Address: 3.139.30.165
Name:	webexapis.com
Address: 3.140.133.193
```

we edit the /etc/hosts file and add that IP and host:

```json
3.140.133.193 webexapis.com
```

if now we issue again the command, then let's see if the issue is solved:

```json
{
"time_redirect": 0.000,
"time_namelookup": 0.005,
"time_connect": 0.118,
"time_appconnect": 0.507,
"time_pretransfer": 0.507,
"time_starttransfer": 0.877,
"time_total": 0.877,
"size_request": 375,
"size_upload": 103,
"size_download": 375,
"size_header": 343
}


```

It seems the issue is related to the name server. Next step would be to troubleshoot the name server and see why it's taking 5 seconds to resolve that url.