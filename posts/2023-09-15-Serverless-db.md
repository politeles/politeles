---
categories:
- DB
- Serverless
- Firebase
- FireStore
date: '2023-07-15'
description: Implementing serverless databases in your architecture.
layout: post
title: Implementing serverless databases in your architecture.
toc: true

---

Storing and querying data is the main job for a database. Don't let the serverless hype to force you redesign the query component of your data!

In this short article, I'm going to describe my journey with serverless databases, why I started using them in the first place and what are the major issues you have to take into account when working with them.

I started my journey with serverless databases due to a mobile project developed in flutter: a relatively new technology developed by Google. While learning it, I discovered Firebase, the serverless suite from Google that integrates seamlessly with the [Flutter framework][flutter].

There are many eye-catching components in the [Firebase][firebase] suite: for instance a serverless Auth service that provides integrations with all the well-known providers like Google, Apple, Twitter, etc.

Among others, Firebase offers a serverless database called [FireStore][firestore]. It's a document database, where you can define collections inside documents. It offers a minimal interface to insert some test documents and a part where you can define the access control rules for the database and the documents in the database.

The querying capabilitites are very interesting, they provide operators and functions to filter data, although there is not a proper query language (like for example in MongoDB).

>I discovered later the main disappointment: it is not possible to run a wildcard search on the database. You can filter by intervals, but you can't search values inside a string. Was I reading right? It seems so. I just wanted to run a query to filter all names starting with Ba*.

There is a solution to implement that, but it requires you to update or redesign the architecture of your serverless app. I'll describe the details later during the post, but you can find them in the documentation of firebase.

Why should anyone want to migrate a database to a serverless database?
There are some advantages, if you ask me:
 - No maintenance tasks: you don't have access to any management console.
 - Planetary scale from scratch: I think this is the main selling point. You can start small and with a really small quote and scale without any upfront investment neither in your architecture nor in the infrastructure.
 - You pay for what you use. (this could be a double-edged sword).

The basic plan of Firebase is free and includes a considerable amount of requests both reads and writes. 


The integration between Firebase products and Flutter is so good that the library handles the presentation layer in your app, the caching and even the content being available when the device doesn't have network connection.

Returning back to the main issue: how do you run a wildcard search in FireStore?

Well, you must add another component to your architecture. An indexing engine. There are several in the market, but one of them is Algolia. Also, you need to create a trigger everytime you create / delete a new document.

The indexing engine is a cloud service that works like a typical index, you define a few fields that are part of the index, and in this case, it's the responsability of the programmer to update the index. Then, you can query that index, which returns your object ID, and then asks FireBase to return that object or the list of objects.

The trigger part must be implemented using a serverless function (and to use that capability from Firebase you need to enable a pay plan). There are some out-of-the-box functions to create this trigger as a serverless function.
I'm going to define the triggers that I'm using here.

The overall architecture of the solution running with this indexing system looks like the following:


Again, we have to choose carefully the balance between the functionals, non-functionals and the need for a serverless solution. Depending on the size of your project it might be worthy to run an old-school traditional relational database, or a document-oriented database.

[flutter]: https://flutter.dev/
[firebase]: https://firebase.google.com/
[firestore]: https://firebase.google.com/docs/firestore