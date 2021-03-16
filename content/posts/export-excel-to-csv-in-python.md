+++ 
draft = false
date = 2021-02-20T00:20:12+02:00
title = "Export excel to csv in python"
description = ""
slug = "export-excel-to-csv-in-python" 
tags = []
categories = []
externalLink = ""
series = []
+++

# How to export Excel file to csv in python
We use the pandas library and the following three lines:

```python
 import pandas as pd
 df = pd.read_excel("Libro2.xlsx",sheet="questionlist")
 df.to_csv('l2.csv',index=False,header=False)
```

In case you want to modify a column, you can do the following to replace some characters:

```python
df.Answers = df.Answers.str.replace("\"","")
```