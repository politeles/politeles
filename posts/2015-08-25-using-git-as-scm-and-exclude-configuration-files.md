---
aliases:
- /using-git-as-scm-and-exclude-configuration-files
categories:
- git
date: '2015-08-25'
description: Some links to work with GIT
layout: post
title: Using Git as SCM and exclude configuration files
toc: true

---

Hi, this post is devoted to explain how do I deal with configuration files when I post them to GIT.
There are very sofisticated proposals:
 - [Git Tools - Interactive Staging](http://git-scm.com/book/ch7-2.html)
 - [when you have secret key in your project, how can pushing to GitHub be possible?](http://stackoverflow.com/questions/2152841/how-to-maintain-mostly-parallel-branches-with-only-a-few-difference/2153000#2153000)

But the working thing to me is the following:
 1. First push the  empty config file to your repo.
 1. Then tell git to ignore the updates on that file
 
```shell
Jose Enrique@MORTIMER /C/Users/Jose Enrique/Documents/nodejs_mongo/nodejs_mongo_server (master)
$ git update-index --assume-unchanged config/config.js</pre> 
```


