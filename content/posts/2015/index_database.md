+++ 
draft = false
date = 2015-06-08T00:09:12+02:00
title = "index database using tipuesearch"
description = ""
slug = "" 
tags = ['tipuesearch']
categories = ['databases']
externalLink = ""
series = []
+++

# Optimizing search on websites with tipuesearch js


```
var tipuesearch = {"pages": [
{"title": "Welcome to JIVE - Guidelines | ACME", "text": "Welcome to the ACME Jive Collaboration platform Please read this document, which contains","tags": "Welcome to JIVE - Guidelines | ACME","url": "http://10.0.82.13/DOC-1001.html"},
{"title": "Datacenter FAQ - ACME ISO Hosting | ACME", "text": "Where are the datacenters located? Do you subcontract activities? We have several datacenters around","tags": "Datacenter FAQ - ACME ISO Hosting | ACME","url": "http://10.0.82.13/DOC-1002.html"},
{"title": "Customer Information template | ACME", "text": "This document will need to become the template that is used to create the information of the custome","tags": "Customer Information template | ACME","url": "http://10.0.82.13/DOC-1003.html"},
{"title": "ISO Customer List | ACME", "text": "Please add customers as content is created. Please ensure you add the name alphabetically. Insert fo","tags": "ISO Customer List | ACME","url": "http://10.0.82.13/DOC-1004.html"},
{"title": "Accenture Phillipines/SiACMEpore - APH - Hosted | ACME", "text": "CustomerAccenture Philippines/SiACMEporealso known asAPHISO Project CodeAPHContract Start date01 June","tags": "Accenture Phillipines/SiACMEpore - APH - Hosted | ACME","url": "http://10.0.82.13/DOC-1006.html"},
{"title": "KB: SAP logon screen hangs - Oracle | ACME", "text": "KeywordsORA 257 00257 ORA-00257 Archivelog system hangs logon login screenSymptomSAP logon screen ap","tags": "KB: SAP logon screen hangs - Oracle | ACME","url": "http://10.0.82.13/DOC-1007.html"},
]};
```


# Creation of the index database using python

```
import urllib2.request
import glob, os
import codecs
import sys
import string
from bs4 import BeautifulSoup
#os.chdir("D:\MergedCopies_17042015\jive.ACME.com\docs\DOC-1008.html")

def paquillo():


    max_lenth = 100
    tag_start = 11

    output_file = open('D:\Documentos\index.json','w+')
    

    os.chdir("D:\MergedCopies_17042015\jive.ACME.com\docs")
    for file in glob.glob("DOC-[0-9][0-9][0-9][0-9].html"):
        print('Document: '+file)
        f = codecs.open(file,encoding='utf-8')
        doc = BeautifulSoup(f.read())
        if len(doc.select('.jive-rendered-content'))>0:
            text = doc.select('.jive-rendered-content')[0]
            text_lenth = len(text.get_text())
            if text_lenth>=max_lenth:
                content_text =  text.get_text()[:max_lenth]
            elif text_lenth==0:
                content_text = doc.title.string
            else :
                content_text = text.get_text()
        else :
            content_text = doc.title.string

        if len(doc.select('.jive-icon-med .jive-icon-folder'))>0:
            tags = doc.select('.jive-icon-med .jive-icon-folder')[0]
            tag_lenth = len(tags.get_text())
            if tag_lenth > tag_start:
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


# Resources
[tipue search](http://www.tipue.com/search/)

	