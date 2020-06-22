---
title       : Order of Growth of Algorithms
date        : 2020-06-22 09:58:31 +0800
modified    : 2020-06-22 09:58:31 +0800
tags        : [python, problem, solution, discrete math, algorithms, foundations]
description :
series      :
usemathjax  : true
---

One of the most important question asked when dealing with algorithms is: how long does this algorithm take to run? And how does its running time scale with the input size?

For any algorithm, there are three characteristic functions we need to put our attention to. These are:
- $( T_{worst}(n)$:  the running time in the worst case
- $( T_{average}(n)$:  the running time in the average case
- $( T_{best}(n)$:  the running time in the best case

Let's take for instance insertion sort. Insertion sort algorithm is a simple algorithm in which array elements iis sorted in place, one entry at a time. Although not the fastest sorting algorithm, it is very simple to implement and does not require additional memory aside from the space we use to store the input array.

Every iteration $i$ of the insertion sort removes one element from the input data and inserts it into the correct position in the already sorted sub-array $A[j]$ for $0 \le j \lt i $. The algorithm iterates $n$ times (where $n$ is the total size of the input array) until no input elements remains to be sorted.

```python
def insertion_sort(A: list):
    for i in range(1, len(A)):
        for j in range(i, 0, -1):
            if A[j] < A[j-1]:
                A[j], A[j-1] = A[j-1], A[j]
            else:
                break
```

The best case for an insertion sort is reaaliized when the input is already sorteed. In this case, the inner loop will exit for every iteration which will give us a total of $n$ number of iiterations. Therefore, $ T_{worst}(n) \propto n^2$. However, the worst case, when the array is sorted in reverse.
