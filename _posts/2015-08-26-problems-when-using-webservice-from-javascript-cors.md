---
toc: true
layout: post
description: Some ideas on how to solve problems with CORS.
categories: [webservices nodejs javascript CORS]
title:  Problems when using webservice from Javascript CORS
---

Hi, I've been fighting the whole day for the security constraint that makes your browser blocks your JS code when trying to reach an external server.
Thas was solved on the  standard Cross Origin Resource Sharing. (CORS for short).
In my node JS server code I had to adapt the following:

```javascript 
//enable Cross Origin Resource Sharing
app.use(function(req, res, next) {
  res.header("Access-Control-Allow-Origin", "*");
  res.header('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE,OPTIONS');
  res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
  next();
});
```

and on my Jquery I did:

```javascript 
//This is how your data looks like:
var data = {"answers": 
	[
	{"testNo":"1","answerNo":"2","answerValue":"answer1"},
	{"testNo":"1","answerNo":"2","answerValue":"answer1"}
	],
	"userId":"idUser"};


// This is the object for the configuration:
var config = {};
	  config.method = "PUT";
	  config.url = "http://localhost:8080/api/users";
	  config.contentType = "application/json";
	  config.data = JSON.stringify(data);
	  config.datatype = "text";

	  $.ajax(config)
			.done(function(msg){
					console.log(msg != null,"Function called: "+msg);
	  });
```

The full code of this is [available at my github account](https://github.com/politeles/nodejs_mongo_server)