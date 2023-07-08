---
aliases:
- /2016/09/05/Create-an-SSL-certificate-with-openSSL
categories:
- OpenSSL 
- SSL
date: '2016-09-05'
description: command to create a selfsigned SSL certificate
layout: post
title: Create an SSL certificate with openSSL
toc: true

---

# Create an SSL certificate with openSSL

Create a selfsigned SSL certificate

With openssl:

```shell
openssl req -x509 -nodes -days 7300 -newkey rsa:2048 -keyout /etc/ssl/certs/vsftpd.pem -out /etc/ssl/certs/vsftpd.pem 
```