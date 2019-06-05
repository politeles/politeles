+++ 
draft = false
date = 2015-08-24T00:09:12+02:00
title = "Firsts steps with MongoDB + mongoose"
description = ""
slug = "firsts-steps-with-mongodb-mongoose" 
tags = []
categories = []
externalLink = ""
series = []
+++





Basically I want to create a database for my JSON documents. Documents have the following format.
 
{{< highlight js >}} {"userId":"userIdValue",
 answers:[
 {"idUser":1111,"testNo":1,"answerNo":2,"answerValue":"answer1"},
 {"idUser":1111,"testNo":1,"answerNo":2,"answerValue":"answer1"}
 ]}{{< /highlight >}}

The steps to be able to store documents on my mongoDB are the following:
<ol>
	<li>Create a collection for my docs.(It's created implicitly)</li>
	<li><a href="http://jpons.es/2015/05/06/how-to-create-and-modify-admin-users-in-mongo-db/" target="_blank">Create a power user on that collection</a></li>
	<li>Do basic CRUD operations on the database to test. i'll create the collection "answers" and insert a test document.

 
{{< highlight js >}}db.answers.insert(
	{
		"userId":"userIdValue",
		answers:[
			{"idUser":1111,"testNo":1,"answerNo":2,"answerValue":"answer1"},
			{"idUser":1111,"testNo":1,"answerNo":2,"answerValue":"answer1"}
				]
	}
 ){{< /highlight >}}


</li>
	<li>Configure the connection in the adapter for your app. In my case I will configure mongoose, I'm using Node JS to connect to MongoDB.
Watch out! <a href="http://docs.mongodb.org/manual/core/authentication/" target="_blank">As of version 3.0, the authentication mechanism by default changed</a>
So I was getting this error, mainly due to an old mongoose lib:
 
{{< highlight js >}}2015-08-22T10:56:22.477+0200 I ACCESS   [conn17] Failed to authenticate adminUse
r@users with mechanism MONGODB-CR: AuthenticationFailed MONGODB-CR credentials m
issing in the user document
2015-08-22T10:56:22.477+0200 I ACCESS   [conn18]  authenticate db: users { authe
nticate: 1, user: "adminUser", nonce: "xxx", key: "xxx" }{{< /highlight >}}

The solution is simple, first check the admin user has the role userAdminAnyDatabase. If you already created it:
 
{{< highlight js >}}use admin;
db.updateUser(
"admin",
{roles: [ { role: "userAdminAnyDatabase", db: "admin" } ]  }
){{< /highlight >}}

update to the lastest mongoose client library, on nodeJS update your package.json:
 
{{< highlight js >}}{
    "name": "node-server",
    "main": "server.js",
    "dependencies": {
        "express": "~4.0.0",
        "mongoose": "~4.1.3",
        "body-parser": "~1.13.3"
    }
}{{< /highlight >}}


Now you will see your client can authenticate:
 
{{< highlight bash >}}2015-08-22T11:31:53.914+0200 I NETWORK  [initandlisten] connection accepted from
 127.0.0.1:51726 #32 (2 connections now open)
2015-08-22T11:31:54.426+0200 I ACCESS   [conn32] Successfully authenticated as p
rincipal adminUser on users{{< /highlight >}}

Now let's test the user storage:
On your nodeJS code:
 
{{< highlight js >}}	var user = new User(req.body);
		//try to save the user:
		user.save(function (err){
			if(err){
				res.send(err);
			}else{
				res.json({message:"User created"});
			}
		}){{< /highlight >}}

Notice that the user is stored on database users, on collection users:
 
{{< highlight bash >}}&gt; db.users.find();
{ "_id" : ObjectId("55d841a60f8123581f590c58"), "userId" : 1254, "answers" : [ {
 "testNo" : 1, "answerNo" : 1, "answerValue" : "Myanswer1", "_id" : ObjectId("55
d841a60f8123581f590c5e") }, { "testNo" : 1, "answerNo" : 2, "answerValue" : "Mya
nswer2", "_id" : ObjectId("55d841a60f8123581f590c5d") }, { "testNo" : 1, "answer
No" : 3, "answerValue" : "Myanswer3", "_id" : ObjectId("55d841a60f8123581f590c5c
") }, { "testNo" : 1, "answerNo" : 4, "answerValue" : "Myanswer4", "_id" : Objec
tId("55d841a60f8123581f590c5b") }, { "testNo" : 1, "answerNo" : 5, "answerValue"
 : "Myanswer5", "_id" : ObjectId("55d841a60f8123581f590c5a") }, { "testNo" : 1,
"answerNo" : 6, "answerValue" : "Myanswer6", "_id" : ObjectId("55d841a60f8123581
f590c59") } ], "__v" : 0 }
{ "_id" : ObjectId("55d845a52b4672c819cc32c6"), "userId" : 1254, "answers" : [ {
 "testNo" : 1, "answerNo" : 1, "answerValue" : "Myanswer1", "_id" : ObjectId("55
d845a52b4672c819cc32cc") }, { "testNo" : 1, "answerNo" : 2, "answerValue" : "Mya
nswer2", "_id" : ObjectId("55d845a52b4672c819cc32cb") }, { "testNo" : 1, "answer
No" : 3, "answerValue" : "Myanswer3", "_id" : ObjectId("55d845a52b4672c819cc32ca
") }, { "testNo" : 1, "answerNo" : 4, "answerValue" : "Myanswer4", "_id" : Objec
tId("55d845a52b4672c819cc32c9") }, { "testNo" : 1, "answerNo" : 5, "answerValue"
 : "Myanswer5", "_id" : ObjectId("55d845a52b4672c819cc32c8") }, { "testNo" : 1,
"answerNo" : 6, "answerValue" : "Myanswer6", "_id" : ObjectId("55d845a52b4672c81
9cc32c7") } ], "__v" : 0 }
{{< /highlight >}} 
On my nodeJS server I've also set the output of the object, so I can see the MongoID!!
 
{{< highlight js >}}// show json  request:
		console.log("Request: "+JSON.stringify(user));{{< /highlight >}}
On the console output:
 
{{< highlight js >}}Request: {"userId":1254,"_id":"55d84608b0bef9841e7bf5f9","answers":[{"testNo":1,
"answerNo":1,"answerValue":"Myanswer1","_id":"55d84608b0bef9841e7bf5ff"},{"testN
o":1,"answerNo":2,"answerValue":"Myanswer2","_id":"55d84608b0bef9841e7bf5fe"},{"
testNo":1,"answerNo":3,"answerValue":"Myanswer3","_id":"55d84608b0bef9841e7bf5fd
"},{"testNo":1,"answerNo":4,"answerValue":"Myanswer4","_id":"55d84608b0bef9841e7
bf5fc"},{"testNo":1,"answerNo":5,"answerValue":"Myanswer5","_id":"55d84608b0bef9
841e7bf5fb"},{"testNo":1,"answerNo":6,"answerValue":"Myanswer6","_id":"55d84608b
0bef9841e7bf5fa"}]}{{< /highlight >}}
So I got this _id: "_id":"55d84608b0bef9841e7bf5f9"

</li>

</ol>

