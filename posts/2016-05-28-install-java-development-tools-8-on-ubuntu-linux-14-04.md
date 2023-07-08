---
aliases:
- /2016/05/28/install-java-development-tools-8-on-ubuntu-linux-14-04
categories:
- java 
- linux 
- ubuntu
date: '2016-05-28'
description: How to install java dev tools on ubuntu.
layout: post
title: Install java development tools >= 8 on ubuntu linux >= 14.04
toc: true

---

Hi there,
I'm trying to install java development tools on my ubuntu, I skim through several guides, but none of them convinced me. <a href="http://tecadmin.net/install-oracle-java-8-jdk-8-ubuntu-via-ppa/">All links I saw</a> just consist on adding a repository to  your apt, and then install with apt from there. But I prefer to have a deep understanding. So I went to <a href="http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html" target="_blank">the official download page for Java 8.</a> And I downloaded the image called <b>linux-x64.tar.gz</b>
[The release instructions are here ](https://docs.oracle.com/javase/8/docs/technotes/guides/install/linux_jdk.html#BJFJJEFG)

Once you have the file downloaded, you have to unzip it and then move to the corresponding folder.
To do so:
```shell
:~/Descargas$ tar -xvf jdk-8u92-linux-x64.tar.gz 
$ sudo mv ~/Descargas/jdk1.8.0_92 /usr/lib/jvm/
```

But then we need to [update-alternatives](http://askubuntu.com/questions/315646/update-java-alternatives-vs-update-alternatives-config-java) to tell ubuntu that we want to work with that java. For the installation of a new program, you can check the [man page for update-alternatives](http://linux.die.net/man/8/update-alternatives).
To install java with symbolic link under /usr/bin/java:

```shell
sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk1.8.0_92/bin/java  1
```

To install javac:

```shell
sudo update-alternatives --install /usr/bin/javac java /usr/lib/jvm/jdk1.8.0_92/bin/javac 1 
```

Now you can check in console the installed versions:

```
java version "1.8.0_92"
Java(TM) SE Runtime Environment (build 1.8.0_92-b14)
Java HotSpot(TM) 64-Bit Server VM (build 25.92-b14, mixed mode)
jpons@bugambilla:/usr/lib/jvm/jdk1.8.0_92/bin$ javac -version
javac 1.8.0_92
```