+++ 
draft = false
date = 2015-08-25T00:09:12+02:00
title = "Using Git as SCM and exclude configuration files"
description = ""
slug = "using-git-as-scm-and-exclude-configuration-files" 
tags = []
categories = []
externalLink = ""
series = []
+++

Hi, this post is devoted to explain how do I deal with configuration files when I post them to GIT.
There are very sofisticated proposals:
<a href="http://git-scm.com/book/ch7-2.html" target="_blank">Git Tools - Interactive Staging</a>
<a href="http://stackoverflow.com/questions/2152841/how-to-maintain-mostly-parallel-branches-with-only-a-few-difference/2153000#2153000" target="_blank">when you have secret key in your project, how can pushing to GitHub be possible?</a>

But the working thing to me is the following:
 1. First push the  empty config file to your repo.
 1. Then tell git to ignore the updates on that file
 
{{< highlight js >}}Jose Enrique@MORTIMER /C/Users/Jose Enrique/Documents/nodejs_mongo/nodejs_mongo_
server (master)
$ git update-index --assume-unchanged config/config.js</pre> 
{{< /highlight >}}


