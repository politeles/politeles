---
toc: true
layout: post
description: How to fix the issue of grunt not working on windows 7
categories: [grunt ruby compass windows]
title:  Compass not running with Grunt on Windows 7
---

I faced the issue that compass was not working on windows 7 64 bits and I solved by installing ruby and then the compass gem. Depending on your system, [you can download ruby here] (http://rubyinstaller.org/downloads/) Then don't forget to set up the environment variables on windows I think you can do that directly from the installer, but also from Computer -> Control Panel -> Edit Environment Variables. Then on System Variables, add to the Path variable the ruby path,

Finally open a CMD terminal and write:

```shell
gem install compass
```
Now grunt should be working well:

```shell
grunt serve
Running "compass:server" (compass) task
directory .tmp/styles 
write .tmp/styles/main.css (0.096s)
write .tmp/styles/main.css.map

Done, without errors.
```