---
toc: true
layout: post
description: Post showing how to index a website using javascript tipuesearch.
categories: [javascript python html]
title:  Indexing a website using javascript search engine
---

Hi, today I'm going to talk about an implementation on Javascript, called [tipue search](http://www.tipue.com/search/).
There are 2 possibilities, one is to perform the search online, that is, to lookup the files and do the search while querying. This is reported as not being as efficient as do an offline index.

So I build an index, based on json, using a python script.

Basically the json I wanted to create looks like this:
 
```json
var tipuesearch = {"pages": [
{"title": "Welcome to JIVE - Guidelines | ", "text": "Welcome to the  Jive Collaboration platform Please read this document, which contains","tags": "Welcome to JIVE - Guidelines | ","url": "http://10.0.82.13/DOC-1001.html"},
{"title": "Datacenter FAQ - NGA ISO Hosting | ", "text": "Where are the datacenters located? Do you subcontract activities? We have several datacenters around","tags": "Datacenter FAQ - NGA ISO Hosting | ","url": "http://10.0.82.13/DOC-1002.html"},
{"title": "Customer Information template | ", "text": "This document will need to become the template that is used to create the information of the custome","tags": "Customer Information template | ","url": "http://10.0.82.13/DOC-1003.html"},
{"title": "ISO Customer List | ", "text": "Please add customers as content is created. Please ensure you add the name alphabetically. Insert fo","tags": "ISO Customer List | ","url": "http://10.0.82.13/DOC-1004.html"},
{"title": "Accenture Phillipines/Singapore - APH - Hosted | ", "text": "CustomerAccenture Philippines/Singaporealso known asAPHISO Project CodeAPHContract Start date01 June","tags": "Accenture Phillipines/Singapore - APH - Hosted | ","url": "http://10.0.82.13/DOC-1006.html"},
{"title": "KB: SAP logon screen hangs - Oracle | ", "text": "KeywordsORA 257 00257 ORA-00257 Archivelog system hangs logon login screenSymptomSAP logon screen ap","tags": "KB: SAP logon screen hangs - Oracle | ","url": "http://10.0.82.13/DOC-1007.html"},
]};

```

The engine needs 3 attributes:
 - title: The title of the web site.
 - text:Some of the content of the site.
 - url: This is important, because on the search results, you will get a link with the url just to click on the results.


I'm indexing some [Jive documents](https://www.jivesoftware.com/). So my script in python to generate the json looks like this:
 
```python
import urllib2.request
import glob, os
import codecs
import sys
import string
from bs4 import BeautifulSoup


def paquillo():


    max_lenth = 100
    tag_start = 11

    output_file = open('D:\Documentos\index.json','w+')
    

    os.chdir("D:\docs")
    for file in glob.glob("DOC-[0-9][0-9][0-9][0-9].html"):
        print('Document: '+file)
        f = codecs.open(file,encoding='utf-8')
        doc = BeautifulSoup(f.read())
        if len(doc.select('.jive-rendered-content'))&gt;0:
            text = doc.select('.jive-rendered-content')[0]
            text_lenth = len(text.get_text())
            if text_lenth&gt;=max_lenth:
                content_text =  text.get_text()[:max_lenth]
            elif text_lenth==0:
                content_text = doc.title.string
            else :
                content_text = text.get_text()
        else :
            content_text = doc.title.string

        if len(doc.select('.jive-icon-med .jive-icon-folder'))&gt;0:
            tags = doc.select('.jive-icon-med .jive-icon-folder')[0]
            tag_lenth = len(tags.get_text())
            if tag_lenth &gt; tag_start:
                tag_text = tags[:-tag_start]
            else :
                tag_text = doc.title.string
        else :
            tag_text = doc.title.string

                    
                
        string_to_file =  ('{\"title\": \"'+string.replace(doc.title.string,'\"','').strip()+'\", \"text\": \"'+
              string.replace(content_text,'\"','').replace('\n','').strip()+'\",'+
              '\"tags\": \"'+string.replace(tag_text,'\"','').strip()+'\",'+
              '\"url\": \"' +  'http://10.0.82.13/' + file +'\"},').encode('utf-8')+'\n'           
        output_file.write(string_to_file)

    output_file.close()
    return 0

def main():
   # sys.setdefaultencoding('utf-8')
    #reload(sys)
    paquillo()

if __name__ == "__main__":
    main()

```





