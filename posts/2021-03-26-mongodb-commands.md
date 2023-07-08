---
aliases:
- /2021/03/26/mongodb-commands
categories:
- MongoDB 
- cli 
- linux
date: '2021-03-26'
description: A list of useful MongoDB commands
layout: post
title: MongoDB commands
toc: true

---

# Connect to mongo using SSL certificates

```shell
mongo --host hostname --port 27027 -ssl --sslPEMKeyFile /path/to/file --sslCAFile /path/to/file
```



# Login as admin user

```shell
use admin
db.auth('user','passwd')
```

# show databases

```shell
show databases
```

# show collections

```shell
show collections
``` 

# explore collections

```shell
db.collectionname.find()
```
