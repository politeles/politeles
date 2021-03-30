+++ 
draft = false
date = 2015-09-25T00:09:12+02:00
title = "choosing a graphic library for jscript"
description = ""
slug = "" 
tags = ['js']
categories = ['library']
externalLink = ""
series = []
+++

# Choosing a graphic library for jscript:

there are several options:

## raphael: 
http://raphaeljs.com/
Light weight and highly compatible crossbrowsers.

## paper.js:
http://paperjs.org/
Looks really powerfull

## Fabric.js:
http://fabricjs.com/

Faster than raphael and supports touch devices.
Sample html with fabrik:
```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <script src="https://rawgit.com/kangax/fabric.js/master/dist/fabric.js"></script>
  </head>
  <body>
    <canvas id="c" width="300" height="300" style="border:1px solid #ccc"></canvas>
    <script>
      (function() {

        var canvas = new fabric.Canvas('c');

      })();
    </script>
  </body>
</html>
```
