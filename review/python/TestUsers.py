"""
    Utility to test users connection.

"""
import codecs
import string
import os
import pandas as pd


class User(object):

    def __init__(self,user_name,password):
        self.user_name = user_name
        self.password = password
        print "user :",self.user_name,"password: ",self.password

class FTPTester(object):

    def __init__(self):
        self.host = ''


    def testFTPS(self, user, pwd,host,port):
        print user,pwd,host,port

    


class UserReader(object):

    def __init__(self,file_name):
        self.file_name = file_name
        self.user_list = []
        

    def readUsersFromFile(self):

        print('running: ',self.file_name,)
        na_values = ['nan']        
        data = pd.read_csv(self.file_name,na_values=na_values,sep=',',encoding='utf-8')
        dataFrame = pd.DataFrame({'user':data['USER-Name']})
        dataFrame['user'].dropna()
        dataFrame = dataFrame['user'].dropna()
        #'pwd':data['USER-Password']}
        f = FTPTester()
        
        
        dataFrame.apply(lambda row:f.testFTPS(row['user'],'pass','rand','port'))
        #dtype={'USER-Name':str,'USER-Password':str}
        #user_and_pass = [data['USER-Name'],data['USER-Password']]
'''
        print data.ix[0:3,'USER-Name']
        
        
        
        #sfEncoded = codecs.getreader('utf-8')(f)
        for line in data.iterrows():
        #frame.dropna():
            print 'line: ',line
            #.lstrip('2')
                
        '''
        
    
        
