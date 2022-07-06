---
toc: true
layout: post
description: command to create a selfsigned SSL certificate
categories: [OpenSSL SSL]
title:  Create an SSL certificate with openSSL
---

# Create an SSL certificate with openSSL

Create a selfsigned SSL certificate

With openssl:

```shell
openssl req -x509 -nodes -days 7300 -newkey rsa:2048 -keyout /etc/ssl/certs/vsftpd.pem -out /etc/ssl/certs/vsftpd.pem 
```