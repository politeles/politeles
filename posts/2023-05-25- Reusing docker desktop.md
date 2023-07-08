---
aliases:
- /2023/05/25/Reusing-docker-desktop
categories:
- Docker
date: '2023-05-25'
description: Come back to k8s for windows after using k8s in other environment.
layout: post
title: Reusing docker desktop for windows.
toc: true

---


# Reusing docker desktop 

After some time doing experiments on kubernetes, I want to work in docker for windows using kubernetes.
[Docker for desktop documentation](https://docs.docker.com/desktop/kubernetes/).

Open a terminal

```cmd
PS C:\Users\polit> kubectl config get-contexts
CURRENT   NAME             CLUSTER          AUTHINFO         NAMESPACE
          docker-desktop   docker-desktop   docker-desktop
*         dppizza          dppizza          dppizza          default


```

and change the current to point to docker-desktop.

```cmd
PS C:\Users\polit> kubectl config use-context docker-desktop
Switched to context "docker-desktop".
```

