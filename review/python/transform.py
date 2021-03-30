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

#output_file = open('D:\Documentos\index.json','w+')
    

#    os.chdir("D:\MergedCopies_17042015\jive.northgatearinso.com\docs")
    os.chdir('D:\Documentos')
    for file in glob.glob("DOC-[0-9][0-9][0-9][0-9].html"):
        print('Document: '+file)
        f = codecs.open(file,encoding='utf-8')
        doc = BeautifulSoup(f.read())
        div = doc.find('div',id='j-satNav')
        print('content:'+div)
        
        # replace search div:
        searchForm = doc.find('form',id='jive-userbar-search-form')
        searchForm['action'] = 'http://10.0.82.13/search.html'
    
             
        
    return 0

def main():
   # sys.setdefaultencoding('utf-8')
    #reload(sys)
    print('Starting')
    paquillo()

if __name__ == "__main__":
    main()


    
    

           

