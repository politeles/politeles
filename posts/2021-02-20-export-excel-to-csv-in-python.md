---
aliases:
- /2021/02/20/export-excel-to-csv-in-python
categories:
- CSV 
- Excel 
- pandas 
- anaconda 
- python
date: '2021-02-20'
description: Quick guide to export from Excel file to CSV in python using Pandas
layout: post
title: Export excel to csv in python
toc: true

---

# How to export Excel file to csv in python
We use the pandas library and the following three lines:

```python
 import pandas as pd
 df = pd.read_excel("Libro2.xlsx",sheet="questionlist")
 df.to_csv('l2.csv',index=False,header=False)
```


Sometimes we need to do some formatting before we export the excel to csv file.

## Convert a column to string type

```python
df.Answers = df.Answers.astype(str)
```
[Check the original in stackoverflow.](https://stackoverflow.com/questions/22005911/convert-columns-to-string-in-pandas)

## Remove new lines

```python
df.Answers = df.Answers.str.replace(r"/\n\r|\n|\r/g",'') 
```

[Check the syntax of replace here.](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.Series.str.replace.html)


In case you want to modify a column, you can do the following to replace some characters:

```python
df.Answers = df.Answers.str.replace("\"","")
```

## Remove all spaces: 
```python
df.Question.apply(lambda x: " ".join(x.split())) 
```

## Remove trailing spaces
```python
df.Answers = df.Answers.str.strip() 
```

## Example program in python

```python
import pandas as pd
import fire

def to_csv(fileName,sheet,outfile):
 df = pd.read_excel(fileName,sheet=sheet)
 for c in df.columns:
  df[c]= df[c].astype(str)
  df[c] = df[c].str.replace(r"/\n\r|\n|\r/g",'')
  df[c] = df[c].str.strip()
 df.to_csv(outfile,index=False,header=False)
 

if __name__ == '__main__':
  fire.Fire(to_csv)

```

[Documentation from pandas](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.Series.str.strip.html)