+++ 
draft = false
date = 2015-08-26T00:09:12+02:00
title = "Problems when using webservice from Javascript: CORS"
description = ""
slug = "problems-when-using-webservice-from-javascript-cors" 
tags = []
categories = []
externalLink = ""
series = []
+++

Hi, I've been fighting the whole day for the security constraint that makes your browser blocks your JS code when trying to reach an external server.
Thas was solved on the  standard Cross Origin Resource Sharing. (CORS for short).
In my node JS server code I had to adapt the following:

 
{{< highlight js >}}//enable Cross Origin Resource Sharing
app.use(function(req, res, next) {
  res.header("Access-Control-Allow-Origin", "*");
  res.header('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE,OPTIONS');
  res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
  next();
});{{< /highlight >}}

and on my Jquery I did:

 
{{< highlight js >}}//This is how your data looks like:
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
{{< /highlight >}}

The full code of this is available at my github account: <a href="https://github.com/politeles/nodejs_mongo_server" target="_blank">https://github.com/politeles/nodejs_mongo_server</a>