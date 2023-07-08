---
aliases:
- /2015/06/08/scripting-with-python
categories:
- python 
- html 
- BeautifulSoup
date: '2015-06-08'
description: Using BeautifulSoup in python to parse Html files
layout: post
title: Get html document titles using python
toc: true

---

Hi, today I'm going to show you the power of python.
I'm working on windows platform, so, [I use Idle environment, you can check more here](https://www.python.org/downloads/windows/).
I wanted to create a script to read a lot of html files and write the title tag to a txt document, I'll use that document to do an index later.

But, it looks like there are no standard functions to parse html files, so I found BeautifulSoup library to process html entities http://www.crummy.com/software/BeautifulSoup/bs4/doc/
I also used the following resources:
Reading unicode characters:
http://stackoverflow.com/questions/147741/character-reading-from-file-in-python

https://docs.python.org/2/install/

Extracting text from html tree:
http://stackoverflow.com/questions/328356/extracting-text-from-html-file-using-python

Get a list of files on a directory:
http://stackoverflow.com/questions/2225564/get-a-filtered-list-of-files-in-a-directory
http://stackoverflow.com/questions/3964681/find-all-files-in-directory-with-extension-txt-with-python

URLlib2 python:
https://docs.python.org/2/library/urllib2.html

With that I could write the following script to get the title from each filename that contains a pattern:

 
```python
#import urllib2.request
import glob, os
import codecs
from bs4 import BeautifulSoup
os.chdir("C:\mydocs")
for file in glob.glob("DOC-[0-9][0-9][0-9][0-9].html"):
    f = codecs.open(file,encoding='utf-8')
    doc = BeautifulSoup(f.read())    
    print(file)
    print(doc.title.string)
```
