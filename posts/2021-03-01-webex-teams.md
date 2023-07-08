---
aliases:
- /2021/03/01/webex-teams
categories:
- javascript 
- webex 
- webservice
date: '2021-03-01'
description: Guide to implement webservices to emulate a bot in webex
layout: post
title: WebEx Teams
toc: true

---

# Webex Teams
Today, we will implement some webservices to emulate a bot in webex. First, we need to design two webservices in nodeJS, then we will synchronize them. For that, we will use nodeJS.

The main site for [Webex Teams for developers is here.](https://developer.webex.com/) There you can define integrations, bots and check the documentation for the API.

## required libraries

```javascript
var express = require('express');
var router = express.Router();
var request = require('request-promise');
```

We are using express and request-promise.


## messages and API call
We test two webservices: the people API and the message post.
We compose the mesage in two steps:
 - First, we compose the body (bodyJSON) with the required information for the API call (message content, the toPersonId value, etc).
 - Then, we create the headers and wrap both headers and body into one single object.

```javascript
 bodyJson = {"markdown": message.replace(/\n\r|\n|\r/g,'<br>').replace(/-/g,"&#45;")};
 to = '123123abmasdf'; // this is your user id
bodyJson.toPersonId = to;
```

Then, the request can be found here:

```javscript
var reqOptions = {
    url: config.spark.baseUrl + "messages",
    method: "POST",
    headers: {
        'Authorization': "Bearer " + sparkChannel.authToken,
        'Content-Type': "application/json; charset=utf-8"
    },
    body: JSON.stringify(bodyJson)
};

```

## Webservice call sync
To synchronize two webservice calls, the first one to the people API and the second one to the messages api, we use javascript promises:

We have promise p1 for the check to the people api and p2 to send the message.
The logic here is that p1 check for user permissions while p2 just send the message if the user is authorized.

```javascript
var p1 = request(reqOptions1).then(function(result){
		result = JSON.parse(result);

		var authorized = false;
		if(result.items[0].orgId === orgId){
			authorized = true;
			userMap[to]={};
		}
		return authorized;
	});
	var p2 = p1.then(function(result){

		if(result){
		return request(reqOptions);
		}else{return;}
		});

return Promise.join(p1,p2,function(results1,results2){
		return;

	});


``` 


