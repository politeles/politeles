+++ 
draft = false
date = 2016-02-19T00:09:12+02:00
title = "Compass not running with Grunt on Windows 7"
description = ""
slug = "compass-not-running-with-grunt-on-windows-7" 
tags = []
categories = []
externalLink = ""
series = []
+++







I faced the issue that compass was not working on windows 7 64 bits and I solved by installing ruby and then the compass gem. Depending on your system, you can download ruby here: http://rubyinstaller.org/downloads/ Then don't forget to set up the environment variables on windows I think you can do that directly from the installer, but also from Computer -> Control Panel -> Edit Environment Variables. Then on System Variables, add to the Path variable the ruby path,
<a href="http://jpons.es/wp-content/uploads/2016/02/928Y7.png" rel="attachment wp-att-2322"><img src="http://jpons.es/wp-content/uploads/2016/02/928Y7-258x300.png" alt="928Y7" width="258" height="300" class="alignnone size-medium wp-image-2322" /></a>
Finally open a CMD terminal and write:

 
{{< highlight bash >}} gem install compass{{< /highlight >}}


Now grunt should be working well:
{{< highlight bash >}}
grunt serve
Running "compass:server" (compass) task
directory .tmp/styles 
write .tmp/styles/main.css (0.096s)
write .tmp/styles/main.css.map

Done, without errors.

{{< /highlight >}}