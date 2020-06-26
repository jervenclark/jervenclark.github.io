---
title       : Problem - One Away
date        : 2020-06-26 14:16:06 +0800
modified    : 2020-06-26 14:16:06 +0800
tags        : [python, problem, solution]
description :
series      :
usemathjax  : true
---

## Problem

> There are three types of edits that can be performed on strings: insert a character, remove a character, or replace a character. Given two strings, write a function to check if they are one edit (or zero edits) away.

```python
def one_away(a: str, b: str):
    return len(set(a) - set(b)) < 2
```
