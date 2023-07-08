---
aliases:
- /2021/01/30/ssh-check-bits
categories:
- ssh 
- cli 
- linux
date: '2021-01-30'
description: Command line to check the number of bits of your ssh key
layout: post
title: How do I know the number of bits and encruption of my public key?
toc: true

---

# How do I know the number of bits and encruption of my public key?

According to [superuser](https://superuser.com/questions/139310/how-can-i-tell-how-many-bits-my-ssh-key-is)

```ssh
ssh-keygen -l -f ~/.ssh/id_rsa.pub
```