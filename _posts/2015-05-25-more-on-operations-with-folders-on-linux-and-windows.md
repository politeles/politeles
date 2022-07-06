---
toc: true
layout: post
description: How to replicate folder structure in windows using robocopy and other commands in linux
categories: [folders windows linux]
title:  More on operations with folders in windows and linux
---


Hi, recently I've been working on some issues dealing with folders on windows and on linux.
For instance,
## Replicate Folder Structure on Windows 
With robocopy is really easy:
 
```shell
robocopy "Source" "Target" /e /xf *
```

For example:
```shell
robocopy "C:\JiveCopy" . /e /xf *
```

## Replicate folder structure on Linux
This requires a little bit of scripting, on bash it would be something like:
 
```shell
cd TARGET && (cd SOURCE; find . -type d ! -name .) | xargs -i mkdir -p "{}"
```

For instance:

```shell 
cd /interfaces/client1 && (cd /interfaces/client_orig; find . -type d ! -name .) | xargs -i mkdir -p "{}"
```

Recently I had also the need to rename all folders containing a given pattern, that is done with the following script:

```shell 
find . -iname "itfq*" -type d -execdir bash -c 'mv "$1" "${1//itfq/itfp}"' _ {} \; 
```

This script renames all folders that contains itfq pattern to itfp.