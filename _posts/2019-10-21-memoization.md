---
layout: default
title: "Memoization"
categories: [python, optimization]
---

# Memoization

<br>

Memoization is a technique in optimization closely related to caching where execution time is sped up by storing results of expensive function calls and returning the cached results when the same input occur again. The set of remembered associations may be a fixed-size set controlled by a replacement algorithm or a fixed set, depending on the nature of the function and its use.

A function can only be memoized, however, if it is referentially transparent. That is, only if the calling function has exactly the same effect as replacing that function call with its return value.

<br>

## Example: Fibonacci Sequence

The fibonacci sequence is a sequence of numbers such that any number, except the first two, is the sum of the previous two:

```
0, 1, 1, 2, 3, 5, 8, 13, 21, ...
```

From this, we can see that the value of the first fibonacci in the sequence is 0, the value of the fourth is 2, and so on. Now, to get any fibonacci number, n, in the sequence we can use the formula:

<p style="text-align: center;" markdown="1">
![equation](/assets/img/fibonacci.svg)
</p>

<br>

## Recursive Attempt

The preceding formula for computing a number in fibonacci can be trivially translated into a recursive python function. But, mechanically translating a formula into a function risks us falling into an infinite recursion without returning a result. To fix this, we have to add base cases.

We can see that first two numbers in the sequence are special cases because neither number is a result of adding two preceding numbers. We can use these as our base cases.

```python
def fib(n: int) -> int:
  if n < 2:
    return 1
  return fib(n - 1) + fib(n - 2)
```

This kind of approach is good when you are calling very small values of n. However, if n starts to grow, the number of calls also starts to grow. Take for instance `fib(4)`. To calculate the result, you need to call the function a total of 9 times. For the 5th element 15 calls, 177 calls to compute 10th and 21891 calls to compute 20th.

<br>

## Rescuing Recursion with Memoization

```python
from typing import Dict

memo: Dict[int, int] = {0: 0, 1: 1}

def fib(n: int) -> int:
  if n not in memo:
    memo[n] = fib(n-1) + fib(n-2)
  return memo[n]
```

This strategy significantly decreases the number of calls. For instance, it will only call the function 39 times for `fib(20)` as opposed to 21,891 times using plain recursion. And since memo is prefilled with 0 and 1, it saves us the complexity of another if statement.

<br>

## Automatic Memoization

Memoization can further be simplified using Python's built in decorator. Each time `fib()` is executed with a novel argument, the decorator causes the return value to be cached and upon future calls of `fib()` with the same argument, the previous return value of `fib()` for that argument is retrieved from cache and returned.

```python
from functools import lru_cache

@lru_cache(maxsize=None)
def fib(n: int) -> int:
  if n < 2:
    return 1
  return fib(n - 1) + fib(n - 2)
```
