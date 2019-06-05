+++ 
draft = false
date = 2015-08-22T00:09:12+02:00
title = "Install MongoDB 3.0+ on Windows"
description = ""
slug = "install-mongodb-3-0-on-windows" 
tags = []
categories = []
externalLink = ""
series = []
+++



Hi again,
this is going to be a small configuration guide for mongo DB on windows. There are a few steps missing on <a href="https://docs.mongodb.org/getting-started/shell/tutorial/install-mongodb-on-windows/" target="_blank">the official instalation guide</a>.
To sum up the steps are the following:
<ol>
	<li><a href="https://www.google.es/url?sa=t&rct=j&q=&esrc=s&source=web&cd=2&cad=rja&uact=8&sqi=2&ved=0CCgQFjABahUKEwjFrdflmLzHAhWFNhoKHTIyBcA&url=https%3A%2F%2Fwww.mongodb.org%2Fdownloads&ei=SSjYVYXlB4XtaLLklIAM&usg=AFQjCNFWaVo_HoVICVRtrgACY-_274I1bA&sig2=vI1k0n-OBr388bp7mI1tPQ" target="_blank">Download the installer</a>. Depending on your version. I have chosen 64-bit.</li>
	<li><a href="https://support.microsoft.com/es-es/kb/2731284" target="_blank">Install Windows hot fix on your system</a></li>
	<li>After the installation, create the configuration and data folders on your system. To keep it simple, I created on the same program folder

 
<pre class="lang:batch decode:true " title="Folder creation" >mkdir C:\Program Files\MongoDB\data
mkdir C:\Program Files\MongoDB\data\db</pre> </li>
	<li>If you plan to run MongoDB server as windows service:
	<ol><li>Open windows firewall for your network for mongoDB</li>
	<li>Create a configuration file
 
<pre class="lang:yaml decode:true " title="configuration file" >systemLog:
    destination: file
    path: "C:/Program Files/MongoDB/data/mongod.log"
storage:
    dbPath: "C:/Program Files/MongoDB/data/db"
</pre> 

</li>
	<li>Install the windows service
 
<pre class="lang:batch decode:true " title="windows service installation" >c:\Archivos de programa\MongoDB\Server\3.0\bin&gt;mongod.exe --config "C:\Program F
iles\MongoDB\config\mongod.cfg" --install

c:\Archivos de programa\MongoDB\Server\3.0\bin&gt;net start mongoDB

El servicio de MongoDB se ha iniciado correctamente.</pre> 
</li>
Beware and check the logs, because even with a successful message you can get errors when trying to connect via the shell client.

</ol>
	

</li>
</li>
	<li>Run shell client and connect
 
<pre class="lang:batch decode:true " title="mongo" >c:\Archivos de programa\MongoDB\Server\3.0\bin&gt;mongo
2015-08-22T09:33:04.923+0200 I CONTROL  Hotfix KB2731284 or later update is not
installed, will zero-out data files
MongoDB shell version: 3.0.5
connecting to: test
2015-08-22T09:33:05.988+0200 W NETWORK  Failed to connect to 127.0.0.1:27017, re
ason: errno:10061 No se puede establecer una conexión ya que el equipo de destin
o denegó expresamente dicha conexión.
2015-08-22T09:33:05.991+0200 E QUERY    Error: couldn't connect to server 127.0.
0.1:27017 (127.0.0.1), connection attempt failed
    at connect (src/mongo/shell/mongo.js:179:14)
    at (connect):1:6 at src/mongo/shell/mongo.js:179
exception: connect failed
</pre> 

So you get an error. That's due to the windows firewall. Allow traffic from mongodb and you will be able to connect.

 
<pre class="lang:batch decode:true " >c:\Archivos de programa\MongoDB\Server\3.0\bin&gt;mongo
2015-08-22T09:39:59.718+0200 I CONTROL  Hotfix KB2731284 or later update is not
installed, will zero-out data files
MongoDB shell version: 3.0.5
connecting to: test
Welcome to the MongoDB shell.
For interactive help, type "help".
For more comprehensive documentation, see
        http://docs.mongodb.org/
Questions? Try the support group
        http://groups.google.com/group/mongodb-user</pre> 

</li>

</ol>


