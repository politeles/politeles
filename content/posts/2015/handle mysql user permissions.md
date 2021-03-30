+++ 
draft = false
date = 2015-02-07T00:09:12+02:00
title = "handling mysql permissions"
description = ""
slug = "" 
tags = ['mysql']
categories = ['databases']
externalLink = ""
series = []
+++

# Handling MySQL users and permissions


```
grant all privileges on <gcc>.* to '<gcc>'@'localhost' identified by '<password';
grant all privileges on <gcc>.* to '<gcc>'@'<FQN_ROR_hostname> ' identified by '<password';
```


# Resources

[13.7.5.17 SHOW GRANTS Syntax](https://dev.mysql.com/doc/refman/5.0/en/show-grants.html)