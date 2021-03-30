+++ 
draft = false
date = 2021-03-26T00:08:27+02:00
title = "MongoDB commands"
description = ""
slug = "" 
tags = ['mongodb']
categories = ['databases']
externalLink = ""
series = ['cli']
+++


# Connect to mongo using SSL certificates

```
mongo --host hostname --port 27027 -ssl --sslPEMKeyFile /path/to/file --sslCAFile /path/to/file
```



# Login as admin user

```
use admin
db.auth('user','passwd')
```

# show databases

```
show databases
```

# show collections

```
show collections
``` 

# explore collections

```
db.collectionname.find()
```
