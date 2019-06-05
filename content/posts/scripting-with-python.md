+++ 
draft = false
date = 2015-06-08T00:09:12+02:00
title = "Scripting with Python"
description = ""
slug = "scripting-with-python" 
tags = []
categories = []
externalLink = ""
series = []
+++


Hi, today I'm going to show you the power of python.
I'm working on windows platform, so, I use Idle environment, you can check more here: <a href="https://www.python.org/downloads/windows/" target="_blank">https://www.python.org/downloads/windows/</a>
I wanted to create a script to read a lot of html files and write the title tag to a txt document, I'll use that document to do an index later.

But, it looks like there are no standard functions to parse html files, so I found BeautifulSoup library to process html entities
<a href="http://www.crummy.com/software/BeautifulSoup/bs4/doc/" target="_blank">http://www.crummy.com/software/BeautifulSoup/bs4/doc/</a>
I also used the following resources:
Reading unicode characters:
<a href="http://stackoverflow.com/questions/147741/character-reading-from-file-in-python" target="_blank">http://stackoverflow.com/questions/147741/character-reading-from-file-in-python</a>

Installing python modules:
<a href="https://docs.python.org/2/install/" target="_blank">https://docs.python.org/2/install/</a>

Extracting text from html tree:
<a href="http://stackoverflow.com/questions/328356/extracting-text-from-html-file-using-python" target="_blank">http://stackoverflow.com/questions/328356/extracting-text-from-html-file-using-python</a>

Get a list of files on a directory:
<a href="http://stackoverflow.com/questions/2225564/get-a-filtered-list-of-files-in-a-directory" target="_blank">http://stackoverflow.com/questions/2225564/get-a-filtered-list-of-files-in-a-directory</a>
<a href="http://stackoverflow.com/questions/3964681/find-all-files-in-directory-with-extension-txt-with-python" target="_blank">http://stackoverflow.com/questions/3964681/find-all-files-in-directory-with-extension-txt-with-python</a>

URLlib2 python:
<a href="https://docs.python.org/2/library/urllib2.html" target="_blank">https://docs.python.org/2/library/urllib2.html</a>

With that I could write the following script to get the title from each filename that contains a pattern:

 
<pre class="lang:python decode:true " title="my small script on python" >#import urllib2.request
import glob, os
import codecs
from bs4 import BeautifulSoup
os.chdir("C:\mydocs")
for file in glob.glob("DOC-[0-9][0-9][0-9][0-9].html"):
    f = codecs.open(file,encoding='utf-8')
    doc = BeautifulSoup(f.read())    
    print(file)
    print(doc.title.string)
</pre> 
