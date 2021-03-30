#import urllib2.request
import glob, os
import codecs
import sys
import string
from bs4 import BeautifulSoup
#os.chdir("D:\MergedCopies_17042015\jive.northgatearinso.com\docs\DOC-1008.html")

def paquillo():


    max_lenth = 100
    tag_start = 11

    output_file = open('D:\Documentos\index.json','w+')
    

#    os.chdir("D:\MergedCopies_17042015\jive.northgatearinso.com\docs")
    os.chdir("D:\)
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


    
    

           

