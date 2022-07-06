---
toc: true
layout: post
description: Command line to check the number of bits of your ssh key
categories: [ssh cli linux]
title:  How do I know the number of bits and encruption of my public key?
---

# How do I know the number of bits and encruption of my public key?

According to [superuser](https://superuser.com/questions/139310/how-can-i-tell-how-many-bits-my-ssh-key-is)

```ssh
ssh-keygen -l -f ~/.ssh/id_rsa.pub
```