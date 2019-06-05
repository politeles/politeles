+++ 
draft = false
date = 2016-06-08T00:09:12+02:00
title = "Big Data Lab"
description = ""
slug = "big-data-lab" 
tags = []
categories = []
externalLink = ""
series = []
+++

# Big Data Lab

Setting up your (small) Big Data Laboratory

I want to learn and work with some of the newest 'Big Data' tools, like Hadoop, Mahout,
Flume, Elastic, etc. But how to do that? Which tecnology should I work with? Is there like a faction of people that only work with Apache products, other just with Amazon.
To choose, and experiment with those technologies I'm going to set up a budget lab at home.

I think it's really important to know what you want to achieve with that lab. 
First of all, what do you want to do? Data Mining? Machine learning? Classification?
It's a great idea to have a toy project to work with.

In my case I want to do the following:

- First, my data set is a collection of terminal outputs with the commands and the output of that commands on different servers.
- On an early stage I want to do a Data Analysis. I want to check if there are any identifiable relationships among the commands I send to the terminal.
Is there any pattern? May I identify clearly the steps when installing a component (i.e. Apache web server) than when I'm resolving an issue (i.e. Apache went down)?

- The possibilities are countless. Maybe after the data analisys I can train a system to learn on how an installation is performed, or how an issue is solved.
After that I could integrate the system and do some stream mining and get suggestions on real time on how to solve an issue.

But first things first. Taking a look to Data Analysis, there are several popular tools, like R, which provides both user interface and a language and libraries to handle data. A reason to choose R is the quick way to inspect and get some nice plots to explore our data.
Also, we can consider Hadoop as engine to store our data sets and also to explore them. From my point of view this option is a little bit more complex at the beggining, but more powerful if you want to explore then some solutions with Mahout, Hive or Flume.


What do I need for my labo?
You need hardware and software products. If you plan to install R, then your laptop would do the job. But if you want to work with hadoop, I recommend you to work with Virtual Machines.
I always try to work with open source solutions so, to create VM, I'll use VirtualBox.

Ok, I'm going to installs VMs, which OS should I install?
There is a great deal of linux flavours to install your VM. I'll cover this step in more detail,
but as far as I can see the most used OS on cloud environments are:
- Ubuntu Server
- Red Hat (RHEL) / CentOS
I also like to work with Devian and Arch due to the low footprint.




Some useful links:

Different hadoop installation manuals:
http://doctuts.readthedocs.io/en/latest/hadoop.html
http://www.michael-noll.com/tutorials/running-hadoop-on-ubuntu-linux-single-node-cluster/
http://www.michael-noll.com/tutorials/
https://wiki.apache.org/hadoop/FrontPage



Data mining using hive:
http://blog.sqlauthority.com/2013/10/21/big-data-data-mining-with-hive-what-is-hive-what-is-hiveql-hql-day-15-of-21/
DAta mining hadoop:

https://developer.yahoo.com/hadoop/tutorial/module3.html

Create a recomender with Mahout in 5 minutes:
https://mahout.apache.org/users/recommender/userbased-5-minutes.html

Apache Flume for streams:
http://flume.apache.org/


ASterix DB:
https://wiki.umiacs.umd.edu/ccc/images/3/32/CLuE-Li.pdf
http://asterix.ics.uci.edu/
