---
toc: true
layout: post
description: Post showing how to index a website using javascript tipuesearch.
categories: [javascript python html]
title:  Install MongoDB 3 on windows
---


Hi again,
this is going to be a small configuration guide for mongo DB on windows. There are a few steps missing on [the official instalation guide](https://docs.mongodb.org/getting-started/shell/tutorial/install-mongodb-on-windows/).
To sum up the steps are the following:
 - [Download the installer](https://www.mongodb.com/try/download/community). 
 - [Install Windows hot fix on your system](https://support.microsoft.com/es-es/kb/2731284)
 - After the installation, create the configuration and data folders on your system. To keep it simple, I created on the same program folder

 
```shell
mkdir C:\Program Files\MongoDB\data
mkdir C:\Program Files\MongoDB\data\db
```
 - If you plan to run MongoDB server as windows service:
  - Open windows firewall for your network for mongoDB
  - Create a configuration file
 
```yaml
systemLog:
    destination: file
    path: "C:/Program Files/MongoDB/data/mongod.log"
storage:
    dbPath: "C:/Program Files/MongoDB/data/db"
```
## Install the windows service
 
```shell
c:\Archivos de programa\MongoDB\Server\3.0\bin&gt;mongod.exe --config "C:\Program Files\MongoDB\config\mongod.cfg" --install

c:\Archivos de programa\MongoDB\Server\3.0\bin>net start mongoDB

El servicio de MongoDB se ha iniciado correctamente.
```

Beware and check the logs, because even with a successful message you can get errors when trying to connect via the shell client.


	

## Run shell client and connect
 
```shell
c:\Archivos de programa\MongoDB\Server\3.0\bin>mongo
2015-08-22T09:33:04.923+0200 I CONTROL  Hotfix KB2731284 or later update is not installed, will zero-out data files MongoDB shell version: 3.0.5
connecting to: test
2015-08-22T09:33:05.988+0200 W NETWORK  Failed to connect to 127.0.0.1:27017, re ason: errno:10061 No se puede establecer una conexión ya que el equipo de destino denegó expresamente dicha conexión.
2015-08-22T09:33:05.991+0200 E QUERY    Error: couldn't connect to server 127.0.0.1:27017 (127.0.0.1), connection attempt failed at connect (src/mongo/shell/mongo.js:179:14)
    at (connect):1:6 at src/mongo/shell/mongo.js:179
exception: connect failed
```

So you get an error. That's due to the windows firewall. Allow traffic from mongodb and you will be able to connect.

```shell
c:\Archivos de programa\MongoDB\Server\3.0\bin>mongo
2015-08-22T09:39:59.718+0200 I CONTROL  Hotfix KB2731284 or later update is not installed, will zero-out data files MongoDB shell version: 3.0.5 connecting to: test 
Welcome to the MongoDB shell.
For interactive help, type "help".
For more comprehensive documentation, see
        http://docs.mongodb.org/
Questions? Try the support group
        http://groups.google.com/group/mongodb-user
```
