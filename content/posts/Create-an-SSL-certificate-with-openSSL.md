+++ 
draft = false
date = 2016-09-05T00:09:12+02:00
title = "Create an SSL certificate with openSSL"
description = ""
slug = "create-an-ssl-ce…ate-with-openssl" 
tags = []
categories = []
externalLink = ""
series = []
+++

# Create an SSL certificate with openSSL

Create a selfsigned SSL certificate

With openssl.

openssl req -x509 -nodes -days 7300 -newkey rsa:2048 -keyout /etc/ssl/certs/vsftpd.pem -out /etc/ssl/certs/vsftpd.pem 