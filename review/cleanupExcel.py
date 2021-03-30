#python class to remove html data from excel file:
import pandas as pd
import numpy as np
import fire
import logging
from bs4 import BeautifulSoup
import re
from unidecode import unidecode
from sklearn import preprocessing
import pickle
import sys

def remove_endl(x):
    txt = x.replace("\r\n"," ")
    txt2 = txt.replace("\n"," ").replace("\t"," ").replace(u"\xa0"," ")
    txt2 = re.sub(' +',' ',txt2)
    return txt2.strip()

def clean_html(x):
    return remove_endl(BeautifulSoup(str(x),"html.parser").get_text())

def save_object(obj, filename):
    with open(filename, 'wb') as output:
        pickle.dump(obj, output, pickle.HIGHEST_PROTOCOL)

def load_object(filename):
    with open(filename, 'rb') as input:
         return pickle.load(input)

def decode(df,feature,le):
	diff = np.setdiff1d(df[feature].unique(),le.classes_)
	if len(diff) > 0:
		print('There are new labels, please correct that')
		print(diff)
		sys.exit(2)

	#	try:
	#		
	#	except ValueError:
	#		self.logger.error('There are new labels, please correct that')
#
	return le.transform(df[feature])

class Cleanup():
	def __init__(self):
		logging.basicConfig(format='%(asctime)s %(levelname)s: %(message)s',level=logging.DEBUG)
		self.logger = logging.getLogger('Cleanup')
	def clean(self,infile,outfile):
		self.logger.info('Loading data')
		
		data = pd.read_excel(infile,sheetname='Raw Data')
		self.logger.info('Total number of rows:'+str(data.shape[0]))
		data = data.applymap(lambda x: x.encode('unicode_escape').decode('utf-8') if isinstance(x, str) else x)
		encoder_sp = load_object('le_sp_full')
		encoder_rt = load_object('le_rt')
		self.logger.info('Cleaning data')
		for col in ['Request Type','Service Process']:
			self.logger.info('Column: '+col)
			data[col] = data[col].apply(str)
			data[col] = data[col].apply(lambda x: remove_endl(x))

		#specific to service process:
		index = data.index[data['Service Process']=='Pre Payroll']
		data.loc[index,'Service Process'] = 'Pre-Payroll'
		index = data.index[data['Service Process']=='Off-Cycle Process']
		data.loc[index,'Service Process'] = 'Off-cycle Process'
		index = data.index[data['Service Process']=='Reconciliation of accounting files']
		data.loc[index,'Service Process'] = 'Reconciliation of Accounting Files'
		index = data.index[data['Service Process']=='EDM - Change in Work Condition']
		data.loc[index,'Service Process'] = 'EDM - Change In Work Condition'
		index = data.index[data['Service Process']=='Application Change Request Management (7.4.2)']
		data.loc[index,'Service Process'] = 'Application Change Request Management'

		index = data.index[data['Service Process']=='nan']
		self.logger.info('Number of NaN data:'+str(len(index)))
		data.drop(index,inplace=True)

		self.logger.info('deleting NaN data number of resulting rows:'+str(data.shape[0]))

		data['Service Process'] = decode(data,'Service Process',encoder_sp)
		data['Request Type'] = decode(data,'Request Type',encoder_rt)
		
		data = data[['DESCRIPTION','ShortDescription','Request Type','Service Process']]

		data.to_csv(outfile,index=False,columns=['DESCRIPTION','ShortDescription','Request Type','Service Process'])

	def shuffle(self,infile,outfile):
		data = pd.read_csv(infile)
		data= data.sample(frac=1)
		data.to_csv(outfile,index=False)

	def merge(self,infile1,infile2,outfile):
		data1 = pd.read_csv(infile1)
		data2 = pd.read_csv(infile2)
		result = pd.concat([data1,data2])
		result.to_csv(outfile,index=False)

   



def main():
 fire.Fire(Cleanup)

if __name__ == '__main__':
 main()
