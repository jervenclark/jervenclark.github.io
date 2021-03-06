---
title       : Problem - Is Permutation?
date        : 2020-06-18 22:41:33 +0800
modified    : 2020-06-18 22:41:33 +0800
tags        : [python, problem, solution]
description :
series      :
---

> Given two strings, write a method to decide if one is a permutation of the other

```python
def isPermutation(first_string: str, second_string: str):
    '''
    Decide if one string is a permutation of the other

    Args:
        first_string (str): The first string to be compared.
        second_string (str): The second string to be compared.

    Returns:
        bool: The return value. True if one is a permutation of
        the other, False otherwise.
    '''

    # Check if both strings have the equal length
    if len(first_string) != len(second_string):
        return False

    # Initialize dictionaries
    first_dict, second_dict = {}, {}

    # Iterate over each character
    for c in zip(first_string, second_string):
        first_dict[c[0]] = first_dict.get(c[0], 0) + 1
        second_dict[c[1]] = second_dict.get(c[1], 0) + 1

    return set(first_dict.items()) == set(second_dict.items())
```


Now, to test our function

```shell
>>> isPermutation('typhon', 'python')
True

>>> isPermutation('wins', 'swim')
False
```

Alternatively, we can use Counter from the collections module

```python
from collections import Counter


def isPermutation2(first_string: str, second_string: str):
    '''
    Decide if one string is a permutation of the other using Counter

    Args:
        first_string (str): The first string to be compared.
        second_string (str): The second string to be compared.

    Returns:
        bool: The return value. True if one is a permutation of
        the other, False otherwise.
    '''
    return Counter(first_string) == Counter(second_string)
```

```shell
>>> isPermutation2('typhon', 'python')
True

>>> isPermutation2('wins', 'swim')
False
```
