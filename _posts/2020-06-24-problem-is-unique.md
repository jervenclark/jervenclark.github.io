---
title       : Problem - Is Unique?
date        : 2020-06-24 10:57:26 +0800
modified    : 2020-06-24 10:57:26 +0800
tags        : [python, problem, solution]
description :
series      :
usemathjax  : true
---

## Problem

> Implement an algorithm to determine if a string has all unique characters.

```python
def isUnique(s: str):
    _s = {}
    unique = True

    for c in s:
        if c in _s.keys():
            unique = False
            break
        else:
            _s[c] = True

    return unique
```

We start by creating an empty dictionary and building it with the characters of the input string as keys. We check if the key already exists and break else, we add it to our tracking dictionary.

## Problem (variant)

> What if you cannot use any additional data structures?

There is a library from the collections module that we can use for this

```python
from collections import Counter

def is_unique2(s: str):
    return sum([i for i in Counter(s).values() if i > 1]) == 0
```

Essentially, we let the Counter class count all character occurences in the string and keep all non unique instance. Another way to go about this is to create a set.

```python
def is_unique3(s: str):
    return len(set(s)) == len(s)
```

This is the simplest solution. The set converts the list into non-repeating elements. We then test if the length of the list is the same as the original string. If they do not match, then it is not unique and there were characters dropped.
