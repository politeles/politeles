+++ 
draft = false
date = 2015-05-06T00:09:12+02:00
title = "How to create and modify admin users in Mongo db"
description = ""
slug = "how-to-create-and-modify-admin-users-in-mongo-db" 
tags = []
categories = []
externalLink = ""
series = []
+++

Today's post is related to some repetitive administrative tasks related to database administration like the setup of a user and grant some permissions on Mongo db. I will perform all activities on<a href="http://docs.mongodb.org/manual/reference/mongo-shell/" target="_blank"> the Javascript shell for Mongo.</a>

First of all, it's important to know whether mongo server is running or not. In windows, you may run it as a <a href="http://docs.mongodb.org/manual/tutorial/install-mongodb-on-windows/#begin-using-mongodb" target="_blank">service</a>. But in this case, I'll run it in foreground:
<pre class="theme:dark-terminal striped:false marking:false ranges:false nums:false nums-toggle:false lang:batch highlight:0 decode:true " title="Start up mongo db " >
C:\Users\JoseEnriqueP&amp;gt;mongod --dbpath .
2015-05-06T23:05:03.205+0200
2015-05-06T23:05:03.222+0200 warning: 32-bit servers don't have journaling enabled by default. Please use --journal if you want durability.</pre> 

Connect to mongo in the usual way:
<pre class="theme:dark-terminal striped:false marking:false ranges:false nums:false nums-toggle:false lang:batch highlight:0 decode:true " title="Start up mongo db " >
C:\Users\JoseEnriqueP&gt;mongo
MongoDB shell version: 2.6.5
connecting to: test
</pre>
Change to use the administration database and create an administration user.

In this link you will see how to <a href="http://docs.mongodb.org/manual/tutorial/add-user-administrator/" target="_blank">create an admin user in Mongo DB</a> and also how to <a href="http://docs.mongodb.org/manual/administration/security-user-role-management/" target="_blank">manage roles and user profiles in mongo</a>.
<pre class="theme:dark-terminal striped:false marking:false ranges:false nums:false nums-toggle:false lang:batch highlight:0 decode:true " title="Start up mongo db " >
&gt; use admin;
switched to db admin
 db.createUser(
   {
 	user: "admin",
 	pwd: "yourPasswordHere",
 	roles:
 	[
   	{
     	role: "dbOwner",
     	db: "admin"
   	}
 	]
   }
 )
</pre>
Note that the user is now the owner of that db. You will get a confirmation that the user was created successfully:
<pre class="theme:dark-terminal striped:false marking:false ranges:false nums:false nums-toggle:false lang:batch highlight:0 decode:true " title="Start up mongo db " >
Successfully added user: {
        "user" : "admin",
        "roles" : [
                {
                        "role" : "dbOwner",
                        "db" : "admin"
                }
        ]
}
</pre>
In this <a href="http://docs.mongodb.org/manual/reference/security/" target="_blank">link</a> you have a complete reference for all users related operations that can be done on Mongo DB.

To change the password of a given user in Mongo DB you need an administrative user. After that, you log into the database and change the password in the following way:
<pre class="theme:dark-terminal striped:false marking:false ranges:false nums:false nums-toggle:false lang:batch highlight:0 decode:true " title="Start up mongo db " >db.changeUserPassword('user','newpassword');
</pre>
You won't get any notification that the password was changed, but try to log with the new password and you should get a '1':
<pre class="theme:dark-terminal striped:false marking:false ranges:false nums:false nums-toggle:false lang:batch highlight:0 decode:true " title="Start up mongo db " >&gt; db.auth('admin','newpass');
1
</pre>