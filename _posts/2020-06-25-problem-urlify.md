---
title       : Problem - URLify
date        : 2020-06-25 14:34:45 +0800
modified    : 2020-06-25 14:34:45 +0800
tags        : [python, problem, solution]
description :
series      :
usemathjax  : true
---

## Problem

> Write a method to replace all spaces in a string with '%20'. You may assume that the string has sufficient space at the end to hold the additional characters and that you are given the true length of the string.

```python
def urlify(s: str):
    return "".join([i if i != ' ' else '%20' for i in s])
```

We can also use the built-in replace method

```python
def urlify2(s: str):
    return s.replace(' ', '%20')
```

