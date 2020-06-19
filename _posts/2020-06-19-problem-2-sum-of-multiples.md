---
title: Problem 2 - Sum of Multiples
date: 2020-06-19 10:14:02 +0800
modified: 2020-06-19 10:14:02 +0800
tags: [python, problem, solution]
description:
series:
usemathjax: true
---

## Problem

> Given a list of numbers, return the sum of all multiples of n or m
>
> i.e. n = 3, m = 5, numbers = [ 1, 2, 3, 4, 5, 6, 7, 8, 9 ]
>
> Listing all the multiples of 3 and 5 gives us [ 3, 5, 6, 9 ] with a sum of 23
>

We can easily check if a number, x, is a multiple of y if x can divide y without any remainders. For this, we can use the modulo operator.

For example:

```python
# test if a number is divisible by 3
x % 3 == 0

# test if a number is divisible by 5
x % 5 == 0
```

Now, with this in mind we can get all multiples of 3 and 5. Using on our example:


```python
numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9]
[e for e in numbers if e % 5 == 0 or e % 3 == 0]
```

This gives us the expected `[3, 5, 6, 9]` list of numbers. Putting it all together:


```python
from typing import List


def sum_of_multiples(n: int, m: int, numbers: List):
    multiples = [e for e in numbers if e % n == 0 or e % m == 0]
    return sum(multiples)
```

**Test**:

```python
assert sum_of_multiples(3, 5, [1, 2, 3, 4, 5, 6, 7, 8, 9]) == 23
```

## Problem (variant)

> Given an upper bound, generate an array of positive integers less than the upper bound and return the sum of all multiples of n or m


```python
def sum_of_multiples2(n: int, m: int, upper_bound: int):
    multiples = [e for e in range(upper_bound) if e % n == 0 or e % m == 0]
    return sum(multiples)
```

**Test**:

```python
assert sum_of_multiples2(3, 5, 10) == 23
assert sum_of_multiples2(3, 5, 1000) == 233168
```
