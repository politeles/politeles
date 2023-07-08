---
aliases:
- /2015/05/06/how-to-create-and-modify-admin-users-in-mongo-db
categories:
- mongoDB 
- databases
date: '2015-05-06'
description: Commands for user creation in MongoDB
layout: post
title: How to create and modify admin users in Mongo DB
toc: true

---

Today's post is related to some repetitive administrative tasks related to database administration like the setup of a user and grant some permissions on Mongo db. I will perform all activities on<a href="http://docs.mongodb.org/manual/reference/mongo-shell/" target="_blank"> the Javascript shell for Mongo.</a>

First of all, it's important to know whether mongo server is running or not. In windows, you may run it as a [service](http://docs.mongodb.org/manual/tutorial/install-mongodb-on-windows/#begin-using-mongodb). But in this case, I'll run it in foreground:

```shell
C:\Users\JoseEnriqueP>mongod --dbpath .
2015-05-06T23:05:03.205+0200
2015-05-06T23:05:03.222+0200 warning: 32-bit servers don't have journaling enabled by default. Please use --journal if you want durability.</pre> 
```

Connect to mongo in the usual way and start it up:

```shell
C:\Users\JoseEnriqueP>mongo
MongoDB shell version: 2.6.5
connecting to: test
```

Change to use the administration database and create an administration user.

In this link you will see how to [create an admin user in Mongo DB](http://docs.mongodb.org/manual/tutorial/add-user-administrator/create) and also how to [manage roles and user profiles in mongo](http://docs.mongodb.org/manual/administration/security-user-role-management).

```shell
>use admin;
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
```

Note that the user is now the owner of that db. You will get a confirmation that the user was created successfully:

```shell
Successfully added user: {
        "user" : "admin",
        "roles" : [
                {
                        "role" : "dbOwner",
                        "db" : "admin"
                }
        ]
}
```

[In this link](http://docs.mongodb.org/manual/reference/security/) you have a complete reference for all users related operations that can be done on Mongo DB.

To change the password of a given user in Mongo DB you need an administrative user. After that, you log into the database and change the password in the following way:

```shell
>db.changeUserPassword('user','newpassword');
```

You won't get any notification that the password was changed, but try to log with the new password and you should get a '1':

```shell
>db.auth('admin','newpass');
1
```