+++ 
draft = false
date = 2021-03-29T00:09:12+02:00
title = "Kore.AI export knowledge base into batch testing"
description = ""
slug = "" 
tags = []
categories = []
externalLink = ""
series = []
+++

# How to export the knowledge base and transform into batch testing

We need to transform between 2 JSON files. The knowledge base can be extracted from the tool, and the Batch testing only needs some items from there.

We will be using the Google Fire library to wrap our code.

```
import json
import fire

def create_test(knowledge_base,outfile):
	with open(knowledge_base,'r',encoding='utf-8') as f:
		data = json.load(f)

	tests = {'testCases':[]}

	for term in data['faqs']:
	    key = term['question']
	    tests['testCases'].append({'input':key,'intent':key})
	    for alt in term['alternateQuestions']:
	    	if not alt['question'].startswith('||'):
	    		tests['testCases'].append({'input':alt['question'],'intent':key})


	with open(outfile,'w',encoding='utf-8') as out:
		json.dump(tests,out)

if __name__ == '__main__':
  fire.Fire(create_test)

```



# Resources

[programmiz](https://www.programiz.com/python-programming/json)

[stackoverflow](https://stackoverflow.com/questions/28171696/python-json-to-csv-bad-encoding-unicodedecodeerror-charmap-codec-cant-dec)

[Python Fire](https://github.com/google/python-fire)

[String comparison](https://www.tutorialspoint.com/python/string_startswith.htm)