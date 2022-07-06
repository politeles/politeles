---
toc: true
layout: post
description: Some useful SQL commands to handle permissions
categories: [mysql databases]
title: Handling Mysql permissions
---

{% include info.html text="This is for an old version of MySQL but it may work on your current version" %}

# Handling MySQL users and permissions

```SQL
grant all privileges on <gcc>.* to '<gcc>'@'localhost' identified by '<password';
grant all privileges on <gcc>.* to '<gcc>'@'<FQN_ROR_hostname> ' identified by '<password';
```


# Resources

[13.7.5.17 SHOW GRANTS Syntax](https://dev.mysql.com/doc/refman/5.0/en/show-grants.html)