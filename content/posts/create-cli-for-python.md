+++ 
draft = false
date = 2020-12-15T00:10:12+02:00
title = "Create CLI for python"
description = ""
slug = "create-cli-for-python" 
tags = []
categories = []
externalLink = ""
series = []
+++

# Create CLI for python using Fire

[Fire is a really simple library to build CLI.](https://github.com/google/python-fire)
Install it ( you can use conda as well):

```
pip install fire
```

And then use it in your app, for example here:

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

