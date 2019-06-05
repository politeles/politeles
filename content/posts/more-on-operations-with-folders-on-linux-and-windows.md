+++ 
draft = false
date = 2015-05-25T00:09:12+02:00
title = "More on operations with folders on Linux and Windows"
description = ""
slug = "more-on-operations-with-folders-on-linux-and-windows" 
tags = []
categories = []
externalLink = ""
series = []
+++


Hi, recently I've been working on some issues dealing with folders on windows and on linux.
For instance,
<h2>Replicate Folder Structure on Windows </h2>
With robocopy is really easy:
 
<pre class="theme:dark-terminal lang:batch decode:true " title="Robocopy" >robocopy "Source" "Target" /e /xf *</pre> 
For example:
<pre class="theme:dark-terminal lang:batch decode:true " >robocopy "C:\JiveCopy" . /e /xf *</pre> 

<h2>Replicate folder structure on Linux</h2>
This requires a little bit of scripting, on bash it would be something like:
 
<pre class="theme:dark-terminal lang:batch decode:true " >cd TARGET &amp;&amp; (cd SOURCE; find . -type d ! -name .) | xargs -i mkdir -p "{}"</pre> 

For instance:

 
<pre class="theme:dark-terminal lang:batch decode:true " >cd /interfaces/client1 &amp;&amp; (cd /interfaces/client_orig; find . -type d ! -name .) | xargs -i mkdir -p "{}"</pre> 

Recently I had also the need to rename all folders containing a given pattern, that is done with the following script:

 
<pre class="theme:dark-terminal lang:batch decode:true " >find . -iname "itfq*" -type d -execdir bash -c 'mv "$1" "${1//itfq/itfp}"' _ {} \; </pre> 

This script renames all folders that contains itfq pattern to itfp.