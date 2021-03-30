#!/usr/bin/python

import sys, getopt

def main(argv):
   inputfile = 'C:\\Users\\JoseEnriqueP\\Documents\\KPI\\EP5\\APRIL_2014.txt'
   
   try:
      opts, args = getopt.getopt(argv,"hi:",["ifile="])
   except getopt.GetoptError:
      print ('ep5Reader.py -i <inputfile> ')
      sys.exit(2)
      for opt, arg in opts:
          if opt == '-h':
              print ('ep5Reader.py -i <inputfile> ')
              sys.exit()
          elif opt in ("-i", "--ifile"):
              inputfile = arg         
f = open('C:\\Users\\JoseEnriqueP\\Documents\\KPI\\EP5\\APRIL_2014.txt')
print('Reading file')
lines = f.readlines()
f.close()
firstString = '0100 mySAP Human Resources Measured'
delimiter = '-------------------------------------'
first = 1

for line in lines:
#   print("reading line")
   if firstString in line:
        print('String found')
           if 
#   else:
#     print("not found")

print("finished")




     

