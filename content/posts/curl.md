+++ 
draft = false
date = 2021-03-15T00:18:56+02:00
title = "How to get times from curl"
description = ""
slug = "How-to-get-times-from-curl" 
tags = []
categories = []
externalLink = ""
series = []
+++


# How to get times from curl

We want to do a POST query to Webex APIs, and we want to measure the response time. To do that, we need to write a config file:

```
{\n
"time_redirect": %{time_redirect},\n
"time_namelookup": %{time_namelookup},\n
"time_connect": %{time_connect},\n
"time_appconnect": %{time_appconnect},\n
"time_pretransfer": %{time_pretransfer},\n
"time_starttransfer": %{time_starttransfer},\n
"time_total": %{time_total},\n
"size_request": %{size_request},\n
"size_upload": %{size_upload},\n
"size_download": %{size_download},\n
"size_header": %{size_header}\n
}\n
```

Save it as curlFormat.txt, then you can run your curl query as

```
curl -H "Content-Type: application/json" \
-w "@curlFormat.txt" \
-H "Authorization: Bearer xxxxxxxxxx" \
-X POST \
-d '{"roomId":"xxxxxxxxxxxx","text":"test"}' \
'https://webexapis.com/v1/messages'
```

# Resources
[StackOverflow](https://stackoverflow.com/questions/18215389/how-do-i-measure-request-and-response-times-at-once-using-curl)
[https://discuss.devopscube.com/t/how-to-find-response-time-using-curl-request/436](https://discuss.devopscube.com/t/how-to-find-response-time-using-curl-request/436)
