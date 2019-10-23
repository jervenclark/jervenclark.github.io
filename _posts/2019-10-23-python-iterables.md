---
layout: default
title: "Python Iterables"
categories: [python, basics, generator]
---

# Python Iterables

<!-- toc -->

- [Iterables](#Iterables)
- [Generators](#Generators)
- [Yield and Return](#Yield-and-Return)
- [Example: Triangular Number Series](#Example-Triangular-Number-Series)

<!-- tocstop -->

<br>

## Iterables

Suppose you have a list:

```python
sample_list = [1, 2, 3]
```

You can read items from it one by one:
```python
for item in sample_list:
    print(item)

# Output
1
2
3
```

This process of going over each item is called iteration and objects that can be iterated on are called iterables. You can also generate lists using list comprehension:

```python
# this creates a list [0, 2, 4]
sample_list2 = [x*2 for x in range(3)]
```

Iterables in general are handy because you can read them as much as you like. The downside however, is that you need to store these values in memory which is not always what you want especially if you are dealing with very large values. This is where generators come in.

<br>

## Generators

Generators are iterators but you can only iterate on them exactly once. Generators do not store values in memory but rather generate them on the fly. Hence, the name generator.

```python
sample_generator = (x*x for x in range(3))
```

Defining a generator is the same as list comprehension but instead of using `[]` it is replaced with `()`. And, like a list, you can iterate over `sample_generator` and it will process the items one by one. Iterating over it a second time however results to nothing because it forgets the value once it is done calculating it. Here, it is a trivial example but generators are very useful if you know you have a large set of values that you have to read once.

<br>

## Yield

The yield statement suspends a function execution and sends back a value to the caller, but retains enough state to proceed where it left off. In contrast to the return statement which stops an execution and sending a single value back to the caller.

```python
from typing import Generator

def square_generator(n: int) -> Generator[int, None, None]:
    for item in range(3):
         yield item * item

sample_generator2 = square_generator(3)
```

<br>

## Example: Triangular Number Series

A triangular number or triangle number counts the objects that can form an equilateral triangle. The nth triangle number is the number of dots or balls in a triangle with n dots on a side; It is the sum of the n natural numbers from 1 to n.

<p style="text-align: center;" markdown="1">
![equation](/assets/img/triangle-numbers-visual.svg)
</p>

Thankfully, Gauss already worked out how to solve this by splitting the numbers into 2 groups and adding them vertically:

<p style="text-align: center;" markdown="1">
![equation](/assets/img/triangle-numbers.svg)
</p>

Converting this into a generator, we'd come up with:

```python
from typing import Generator

def triangular_number_generator(n: int) -> Generator[int, None, None]:
    for item in range(1, n):
        yield sum(range(item))


# This outputs
# 0, 1, 3, 6, 10, 15, 21, 28, 36
for i in triangular_number_generator(10):
    print(i)
```

If you iterate over triangular_number_generator, for each iteration of the for loop it runs through a yield statement. If the end of the function is reached and there are no more yield statements, the loop finishes iterating.
