---
toc: true
layout: post
description: Handle odd elements with Hugo
categories: [Hugo]
title: Handle odd elements with Hugo
---

# Handle odd elements with Hugo

We want to attach a CSS property to some objects

```html
<div class="col-md-4 {{ if (modBool  .Params.weight 2) }}align-self-center wwm-down{{ end }}">
        {{ .Render "wwm" }}
</div>
```
(https://discourse.gohugo.io/t/detect-every-odd-post-in-a-range/6582)[More info here]

# Not loading elements in the parent folder

Inside the parent pages folder we should have a _index.md file

(https://github.com/gohugoio/hugo/issues/7362)[Github issue]