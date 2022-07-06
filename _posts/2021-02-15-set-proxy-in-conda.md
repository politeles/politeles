---
toc: true
layout: post
description: Quick guide to set up a proxy for conda
categories: [windows anaconda python]
title:  Set proxy in conda
---

# Set proxy in conda

Some companies run within a proxy, to configure conda so you can install packages, take the following file: *C:\Users\username\.condarc*

Add the line proxy_servers with the IP and port:

```json
ssl_verify: true
channels:
  - conda-forge
  - defaults
proxy_servers:
  http: http://10.49.1.1:8080/
  https: http://10.49.1.1:8080/
```

# Set proxy in pip 

```shell
(base) C:\Users\x>SET http_proxy=http://10.49.1.1:8080/

(base) C:\Users\x>echo %http_proxy%
http://10.49.1.1:8080/

(base) C:\Users\x>SET https_proxy=http://10.49.1.1:8080/

(base) C:\Users\x>pip install fire
Collecting fire
```