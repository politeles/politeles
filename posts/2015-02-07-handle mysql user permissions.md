---
aliases:
- /2015/02/07/handle-mysql-user-permissions
categories:
- mysql 
- databases
date: '2015-02-07'
description: Some useful SQL commands to handle permissions
layout: post
title: Handling Mysql permissions
toc: true

---
This is for an old version of MySQL but it may work on your current version

# Handling MySQL users and permissions

We are going to grant permissions for a given database to a specific user on a specific host.
In the example we grant usage to localhost and a hostname to allow external access.

```sql
grant all privileges on dbname.* to 'dbname'@'localhost' identified by 'password';
grant all privileges on dbname.* to 'dbname'@'<FQN_hostname> ' identified by 'password';
```


# Resources

[13.7.5.17 SHOW GRANTS Syntax](https://dev.mysql.com/doc/refman/5.0/en/show-grants.html)