from http.client import HTTPSConnection
from base64 import b64encode

print("Starting module")
#This sets up the https connection
c = HTTPSConnection("jive.northgatearinso.com")
#we need to base 64 encode it 
#and then decode it to acsii as python 3 stores it as a byte string
userAndPass = b64encode(b"joseenriquep:dppizza1983%.").decode("ascii")
headers = { 'Authorization' : 'Basic %s' %  userAndPass }
#then connect
c.request('GET', '/', headers=headers)
#get the response back
res = c.getresponse()
# at this point you could check the status etc
# this gets the page text
data = res.read()
print("Printing data")
print(data)
print("Status code")
print(res.status)
print("Header")
print(res.getheaders())