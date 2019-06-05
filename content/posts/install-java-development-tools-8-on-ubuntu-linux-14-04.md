+++ 
draft = false
date = 2016-05-28T00:09:12+02:00
title = "Install java development tools >= 8 on ubuntu linux >= 14.04"
description = ""
slug = "install-java-development-tools-8-on-ubuntu-linux-14-04" 
tags = []
categories = []
externalLink = ""
series = []
+++

Hi there,
I'm trying to install java development tools on my ubuntu, I skim through several guides, but none of them convinced me. <a href="http://tecadmin.net/install-oracle-java-8-jdk-8-ubuntu-via-ppa/">All links I saw</a> just consist on adding a repository to  your apt, and then install with apt from there. But I prefer to have a deep understanding. So I went to <a href="http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html" target="_blank">the official download page for Java 8.</a> And I downloaded the image called <b>linux-x64.tar.gz</b>
The release instructions are <a href="https://docs.oracle.com/javase/8/docs/technotes/guides/install/linux_jdk.html#BJFJJEFG" target="_blank">here</a>.

Once you have the file downloaded, you have to unzip it and then move to the corresponding folder.
To do so:
{{< highlight bash >}} 
:~/Descargas$ tar -xvf jdk-8u92-linux-x64.tar.gz 
$ sudo mv ~/Descargas/jdk1.8.0_92 /usr/lib/jvm/
{{< /highlight >}}
But then we need to <a href="http://askubuntu.com/questions/315646/update-java-alternatives-vs-update-alternatives-config-java" target="_blank">update-alternatives to tell ubuntu that we want to work with that java</a>. For the installation of a new program, you can check the <a href="http://linux.die.net/man/8/update-alternatives" target="_blank">man page for update-alternatives</a>.
To install java with symbolic link under /usr/bin/java:

{{< highlight bash >}} 
sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk1.8.0_92/bin/java  1
{{< /highlight >}}
To install javac:
{{< highlight bash >}}
sudo update-alternatives --install /usr/bin/javac java /usr/lib/jvm/jdk1.8.0_92/bin/javac 1 
{{< /highlight >}}
Now you can check in console the installed versions:

{{< highlight bash >}}
java version "1.8.0_92"
Java(TM) SE Runtime Environment (build 1.8.0_92-b14)
Java HotSpot(TM) 64-Bit Server VM (build 25.92-b14, mixed mode)
jpons@bugambilla:/usr/lib/jvm/jdk1.8.0_92/bin$ javac -version
javac 1.8.0_92
{{< /highlight >}}