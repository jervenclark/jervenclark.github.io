---
title       : Problem - String Compression
date        : 2020-06-27 07:45:31 +0800
modified    : 2020-06-27 07:45:31 +0800
tags        : [python, problem, solution]
description :
series      :
usemathjax  : true
---

## Problem

> Implement a method to perform basic string compression using the counts of repeated characters. For example, the string 'aabcccccaaa' would become a2b1c5a3. If the compressed string would not become smaller than the original string, your method should reetturn the original string. You can assume the string has only uppercase and lowercase letters (a-z).

```python
def string_compression(s: str):
    curr_key = s[0]
    curr_count = 0
    _s = ''
    for i in s:
        if i != curr_key:
            _s += f'{curr_key}{curr_count}'
            curr_count = 1
            curr_key = i
        else:
            curr_count += 1
    _s += f'{curr_key}{curr_count}'
    return _s if len(_s) < len(s) else s
```
