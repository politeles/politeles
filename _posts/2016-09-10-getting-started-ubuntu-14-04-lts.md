---
toc: true
layout: post
description: First steps after installing ubuntu 14.04
categories: [linux ubuntu]
title:  Getting started with docker in Ubuntu 14.04 LTS
---

# Getting started with docker in Ubuntu 14.04 LTS

I'm trying to install a small lab system based on Ubuntu. The Docker project is a new step on the virtualization world, which reduces the amount of resources used by the 'guest O.S' since there is no such O.S.

To get an overview on Docker, I recommend to get to the project page and get the resources and the free (an really good) training from there (<a href="https://www.docker.com/" target="_blank">https://www.docker.com/</a>)

I'm going to follow the instructions on the site to [install docker for linux](http://docs.docker.com/linux/step_one/), but I'd like to detail here the problems and the full install I did.

Get to a console and install with the Ubuntu script:

 
```shell
sudo  wget -qO- https://get.docker.com/ | sh
```

 Next you can add your own user to run Docker without root or sudo.
To do so:
If you would like to use Docker as a non-root user, you should now consider adding your user to the "docker" group with something like:

```shell
  sudo usermod -aG docker jpons

Remember that you will have to log out and back in for this to take effect!
```

Trying to run hello world:

```shell
docker run hello-world
Post http:///var/run/docker.sock/v1.19/containers/create: dial unix /var/run/docker.sock: no such file or directory. Are you trying to connect to a TLS-enabled daemon without TLS?
```

Don't forget to start the Docker server, otherwise even the hello world app won't start.
 
```shell
jpons@bugambilla:~$ sudo docker run hello-world
Unable to find image 'hello-world:latest' locally
latest: Pulling from hello-world
a8219747be10: Pull complete 
91c95931e552: Already exists 
hello-world:latest: The image you are pulling has been verified. Important: image verification is a tech preview feature and should not be relied on to provide security.
Digest: sha256:aa03e5d0d5553b4c3473e89c8619cf79df368babd18681cf5daeb82aab55838d
Status: Downloaded newer image for hello-world:latest
Hello from Docker.
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (Assuming it was not already locally available.)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

For more examples and ideas, visit:
 http://docs.docker.com/userguide/
```

 


