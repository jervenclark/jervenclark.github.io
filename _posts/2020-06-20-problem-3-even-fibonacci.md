---
title: Problem 3 - Even Fibonacci
date: 2020-06-20 11:53:48 +0800
modified: 2020-06-20 11:53:48 +0800
tags: [python, problem, solution]
description:
series:
usemathjax: true
---

## Problem

> Given an upper bound n, list all even fibonacci numbers less than or equal to the nth fibonacci number and return the sum
>
> i.e., all fibonacci numbers less than or equal to 10th fibonacci number is:
> [1, 1, 2, 3, 5, 8, 13, 21, 34, 55]
>
> Listing all even elements, we get [2, 8, 34] with sum 44
>


Before we everything else, we need to create a fibonacci sequence generator:


```python
from functools import lru_cache


@lru_cache(maxsize=None)
def fib(n: int):
    if n < 0:
        return 0
    if n < 2:
        return 1
    return fib(n - 1) + fib(n-2)

def fib_sequence(upper_bound: int):
    return [ fib(i) for i in range(upper_bound)]
```

Picking all even elements:


```python
def sum_even_fib(n: int):
    return sum([f for f in fib_sequence(n) if f % 2 == 0])
```

**Test:**


```python
assert sum_even_fib(10) == 44
assert sum_even_fib(20) == 3382
assert sum_even_fib(30) == 1089154
```
