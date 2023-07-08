---
aliases:
- /2015/08/24/firsts-steps-with-mongodb-mongoose
categories:
- python 
- mongodb
date: '2015-08-24'
description: Using mongoose lib on python to access mongoDB
layout: post
title: Firsts steps with MongoDB + mongoose
toc: true

---

Basically I want to create a database for my JSON documents. Documents have the following format.
 
```json 
{"userId":"userIdValue",
 answers:[
 {"idUser":1111,"testNo":1,"answerNo":2,"answerValue":"answer1"},
 {"idUser":1111,"testNo":1,"answerNo":2,"answerValue":"answer1"}
 ]}
```

The steps to be able to store documents on my mongoDB are the following:
 - Create a collection for my docs.(It's created implicitly)
 - <a href="http://jpons.es/2015/05/06/how-to-create-and-modify-admin-users-in-mongo-db/" target="_blank">Create a power user on that collection<
 - Do basic CRUD operations on the database to test. i'll create the collection "answers" and insert a test document.

```json 
db.answers.insert(
	{
		"userId":"userIdValue",
		answers:[
			{"idUser":1111,"testNo":1,"answerNo":2,"answerValue":"answer1"},
			{"idUser":1111,"testNo":1,"answerNo":2,"answerValue":"answer1"}
				]
	}
 )
```

## Configure the connection in the adapter for your app. 
In my case I will configure mongoose, I'm using Node JS to connect to MongoDB.
{% include alert.html text="Watch out! As of version 3.0, the authentication mechanism by default changed" %}

So I was getting this error, mainly due to an old mongoose lib:

```shell 
2015-08-22T10:56:22.477+0200 I ACCESS   [conn17] Failed to authenticate adminUser@users with mechanism MONGODB-CR: AuthenticationFailed MONGODB-CR credentials missing in the user document
2015-08-22T10:56:22.477+0200 I ACCESS   [conn18]  authenticate db: users { authenticate: 1, user: "adminUser", nonce: "xxx", key: "xxx" }
```

The solution is simple, first check the admin user has the role userAdminAnyDatabase. If you already created it:

```shell 
use admin;
db.updateUser(
"admin",
{roles: [ { role: "userAdminAnyDatabase", db: "admin" } ]  }
)
```

update to the lastest mongoose client library, on nodeJS update your package.json:
 
```json
{
    "name": "node-server",
    "main": "server.js",
    "dependencies": {
        "express": "~4.0.0",
        "mongoose": "~4.1.3",
        "body-parser": "~1.13.3"
    }
}
```


Now you will see your client can authenticate:
 
```shell
2015-08-22T11:31:53.914+0200 I NETWORK  [initandlisten] connection accepted from 127.0.0.1:51726 #32 (2 connections now open)
2015-08-22T11:31:54.426+0200 I ACCESS   [conn32] Successfully authenticated as principal adminUser on users
```

Now let's test the user storage:
On your nodeJS code:

```javascript 
var user = new User(req.body);
		//try to save the user:
		user.save(function (err){
			if(err){
				res.send(err);
			}else{
				res.json({message:"User created"});
			}
		})
```

Notice that the user is stored on database users, on collection users:
 
```shell
> db.users.find();
```

```json
{ "_id" : ObjectId("55d841a60f8123581f590c58"), "userId" : 1254, "answers" : [ { "testNo" : 1, "answerNo" : 1, "answerValue" : "Myanswer1", "_id" : ObjectId("55d841a60f8123581f590c5e") }, { "testNo" : 1, "answerNo" : 2, "answerValue" : "Mya
nswer2", "_id" : ObjectId("55d841a60f8123581f590c5d") }, { "testNo" : 1, "answerNo" : 3, "answerValue" : "Myanswer3", "_id" : ObjectId("55d841a60f8123581f590c5c") }, { "testNo" : 1, "answerNo" : 4, "answerValue" : "Myanswer4", "_id" : Objec
tId("55d841a60f8123581f590c5b") }, { "testNo" : 1, "answerNo" : 5, "answerValue" : "Myanswer5", "_id" : ObjectId("55d841a60f8123581f590c5a") }, { "testNo" : 1,"answerNo" : 6, "answerValue" : "Myanswer6", "_id" : ObjectId("55d841a60f8123581
f590c59") } ], "__v" : 0 }
{ "_id" : ObjectId("55d845a52b4672c819cc32c6"), "userId" : 1254, "answers" : [ { "testNo" : 1, "answerNo" : 1, "answerValue" : "Myanswer1", "_id" : ObjectId("55d845a52b4672c819cc32cc") }, { "testNo" : 1, "answerNo" : 2, "answerValue" : "Mya
nswer2", "_id" : ObjectId("55d845a52b4672c819cc32cb") }, { "testNo" : 1, "answerNo" : 3, "answerValue" : "Myanswer3", "_id" : ObjectId("55d845a52b4672c819cc32ca") }, { "testNo" : 1, "answerNo" : 4, "answerValue" : "Myanswer4", "_id" : ObjectId("55d845a52b4672c819cc32c9") }, { "testNo" : 1, "answerNo" : 5, "answerValue"
 : "Myanswer5", "_id" : ObjectId("55d845a52b4672c819cc32c8") }, { "testNo" : 1,"answerNo" : 6, "answerValue" : "Myanswer6", "_id" : ObjectId("55d845a52b4672c819cc32c7") } ], "__v" : 0 }
```

On my nodeJS server I've also set the output of the object, so I can see the MongoID!!
 
```javascript
// show json  request:
	console.log("Request: "+JSON.stringify(user));
```
On the console output:

```json 
Request: 
{"userId":1254,"_id":"55d84608b0bef9841e7bf5f9","answers":[{"testNo":1,"answerNo":1,"answerValue":"Myanswer1","_id":"55d84608b0bef9841e7bf5ff"},{"testNo":1,"answerNo":2,"answerValue":"Myanswer2","_id":"55d84608b0bef9841e7bf5fe"},{"testNo":1,"answerNo":3,"answerValue":"Myanswer3","_id":"55d84608b0bef9841e7bf5fd"},{"testNo":1,"answerNo":4,"answerValue":"Myanswer4","_id":"55d84608b0bef9841e7bf5fc"},{"testNo":1,"answerNo":5,"answerValue":"Myanswer5","_id":"55d84608b0bef9841e7bf5fb"},{"testNo":1,"answerNo":6,"answerValue":"Myanswer6","_id":"55d84608b0bef9841e7bf5fa"}]}
```
So I got this _id: "_id":"55d84608b0bef9841e7bf5f9"
