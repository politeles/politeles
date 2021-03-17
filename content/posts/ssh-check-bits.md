+++ 
draft = false
date = 2021-01-30T00:19:12+02:00
title = "Ssh check bits"
description = ""
slug = "ssh-check-bits" 
tags = []
categories = []
externalLink = ""
series = []
+++

# How do I know the number of bits and encruption of my public key?

According to [superuser](https://superuser.com/questions/139310/how-can-i-tell-how-many-bits-my-ssh-key-is)

```
ssh-keygen -l -f ~/.ssh/id_rsa.pub
```