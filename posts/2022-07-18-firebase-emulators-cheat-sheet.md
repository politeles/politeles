---
aliases:
- /2022/07/18/firebase-emulators-cheat-sheet
categories:
- gcp 
- firebase 
date: '2022-07-18'
description: Firebase emulators cheat sheet
layout: post
title: Firebase emulators cheat sheet
toc: true

---

# Start emulator localy with saved data

```shell
firebase emulators:start --import .\data\
```

# Save data from emulator to file 

```shell
firebase emulators:export ./data/
```

Sample output

```shell
i  Found running emulator hub for project orfeondegranada-c6f3e at http://localhost:4400
? The directory C:\Users\polit\sources\orfeonapp\data already contains export data. Exporting again to the same director
y will overwrite all data. Do you want to continue? Yes
i  Exporting data to: C:\Users\polit\sources\orfeonapp\data
+  Export complete
```

# publish the functions to firebase

```shell
firebase deploy --only functions
```


References:
https://firebase.google.com/docs/functions/manage-functions#modify
