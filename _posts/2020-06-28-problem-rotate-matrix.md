---
title       : Problem - Rotate Matrix
date        : 2020-06-28 09:30:52 +0800
modified    : 2020-06-28 09:30:52 +0800
tags        : [python, problem, solution]
description :
series      :
usemathjax  : true
---

## Problem

> Given an image represented by an NxN matrix, where each pixel in the image is 4 byes, write a method to rotate the image by 90 degrees.

```python
from random import randint


def generate_matrix(n: int):
    return [[ randint(0, 64) for j in range(n) ] for i in range(n)]
```

Flip it 90 degrees

```python
def rotate_matrix(m: list):
    _m = []
    for i in range(len(m)):
        _m.append([])
        for j in range(len(m)):
            _m[i].insert(0, m[j][i])
    return _m
```
