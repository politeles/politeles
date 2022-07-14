---
toc: true
layout: post
description: Installing Algolia as search engine for firebase
categories: [gcp firebase algolia]
title: Installing Algolia in Firebase
---

# Installing Algolia as a search engine for firebase

[Firebase](https://firebase.google.com/) is a very popular service from Google. They provice authentication services, cloud databases, analytics for your apps, and there is a really cool integration with Dart/Flutter.

We are using a [document database called Firestore](https://firebase.google.com/docs/firestore/).

It's a cool document database, with some similar concepts to [MongoDB](https://www.mongodb.com), in the sense it groups the elements o the database in documents and collections. What's different is the grouping of these elements.

First, you define a collection which contains documents. Each document may, at the same time contain attributes and collections.

For instance, my *user* collection contains a set of documents representing each a user. To register the attendance, each user contains a collection with its own attendances (instead of having an *attendance* collection and somehow linking the collection to the user).

![]({{site.baseurl}}/images/2022-02-12-firebase-collection.gif )

In the image, you see, that the user collection, contains documents with the info of each user. The so-called attributes like the user name, email, and so on. But at the user level, that's at the level of the attributes, you can define collections, in this case a collection for the attendance with a set of attributes.

The problem with this way of organizing the information, compared to the typical canonical, relational table shape, is the way to query the information.

How to query? [The search functionality provided with Firestore is quite limited.](https://firebase.google.com/docs/firestore/query-data/queries).

The set of limitations as described in the previous link are the following:

## Query limitations

The following list summarizes Cloud Firestore query limitations:

    - Cloud Firestore provides limited support for logical OR queries. The in, and array-contains-any operators support a logical OR of up to 10 equality (==) or array-contains conditions on a single field. For other cases, create a separate query for each OR condition and merge the query results in your app.
    - In a compound query, range (<, <=, >, >=) and not equals (!=, not-in) comparisons must all filter on the same field.
    - You can use at most one array-contains clause per query. You can't combine array-contains with array-contains-any.
    - You can use at most one in, not-in, or array-contains-any clause per query. You can't combine in , not-in, and array-contains-any in the same query.
    - You can't order your query by a field included in an equality (==) or in clause.
    - The sum of filters, sort orders, and parent document path (1 for a subcollection, 0 for a root collection) in a query cannot exceed 100.

# Algolia to the rescue

One of the limitations is full text search for a given attribute. That is, we can't search for all users starting with *Jos*. 

We can configure Algolia community edition with our Firebase project to run queries like this.
The process is as follows:
 - First, register in Algolia and create a free account. 
 - Create an Algolia application and an index name.
 - Next, [add the Algolia extension to your project. ](https://firebase.google.com/products/extensions/algolia-firestore-algolia-search)
 - After the extension is installed, you will find a cloud function that is triggered every document update. But, if your Firestore database has already some data, you have to create another cloud function (that will be triggered maybe just once) to send all your initial data to Algolia index. [Some tips for that cloud functions are here](https://rsfarias.medium.com/how-to-set-up-firestore-and-algolia-319fcf2c0d37)
 

Export all records:
https://discourse.algolia.com/t/export-all-records-from-firestore-to-indices-with-google-cloud-function/10358/3

Implementation in flutter https://www.algolia.com/doc/guides/building-search-ui/getting-started/how-to/flutter/ios/


