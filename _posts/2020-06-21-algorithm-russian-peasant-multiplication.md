---
title       : Algorithm - Russian Peasant Multiplication
date        : 2020-06-21 12:58:11 +0800
modified    : 2020-06-21 12:58:11 +0800
tags        : [python, problem, solution, discrete math, algorithms, foundations]
description :
series      :
---

## Algorithm

> 1. Find the product of integers a and b, both larger than 1
> 2. Start with two columns on a page, one labeled A and the other B.
> 3. Put the value of a under A and b under B
> 4. Repeat until the B value equals 1
>     1. Calculate a new A value by multiplying the old A value by 2
>     2. Calculate a new B value by dividing the old B value and truncating the result to obtain an integer
> 5. Go down the columns crossing A value whenever the B value is even
> 6. Add the remaining A values and return the sum
>


```python
def russian_peasant_multiplication(a: int, b: int):
    if a < 2 or b < 2:
        return -1

    _a, _b = [a], [b]

    while (b > 1):
        a  *= 2
        b //= 2
        _a.append(a)
        _b.append(b)

    return sum([i[0] for i in zip(_a, _b) if i[1] % 2 != 0])
```

Suppose that the input values are a = 73 and b = 41, we start by creating a table with the following values

| A  | B  |
|:--:|:--:|
| 73 | 41 |

We then calculate the new values for a and by by following step 3 in the algorithm which gives us the following

| A    | B  |
|:----:|:--:|
| 73   | 41 |
| 146  | 20 |
| 292  | 10 |
| 584  | 5  |
| 1168 | 2  |
| 2336 | 1  |

The algorithm ends by returning the value 2993


