+++ 
draft = false
date = 2021-02-15T00:10:12+02:00
title = "Set proxy in conda"
description = ""
slug = "set-proxy-in-conda" 
tags = []
categories = []
externalLink = ""
series = []
+++

# Set proxy in conda

Some companies run within a proxy, to configure conda so you can install packages, take the following file: *C:\Users\username\.condarc*

Add the line proxy_servers with the IP and port:

```
ssl_verify: true
channels:
  - conda-forge
  - defaults
proxy_servers:
  http: http://10.49.1.1:8080/
  https: http://10.49.1.1:8080/
```

# Set proxy in pip 

```
(base) C:\Users\x>SET http_proxy=http://10.49.1.1:8080/

(base) C:\Users\x>echo %http_proxy%
http://10.49.1.1:8080/

(base) C:\Users\x>SET https_proxy=http://10.49.1.1:8080/

(base) C:\Users\x>pip install fire
Collecting fire
```