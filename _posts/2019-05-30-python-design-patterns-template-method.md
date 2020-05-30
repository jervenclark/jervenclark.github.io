---
title: "Python Design Patterns: Template Method"
date: 2019-05-30 18:08:15 +08:00
modified: 2019-05-30 18:08:15 +08:00
tags: [behavioral-pattern, design-pattern, python, object-oriented-programming, oop]
description: 
---

# Python Design Patterns: Template Method

<br>
Arguably, the template method is the most common design pattern in object oriented programming. It is a behavioral pattern that defines the program skeleton while letting subclasses override some methods without changing the algorithm's structure.

<br>

## Code

To successfully implement the template method, first examine the algorithm and decide which steps are standard and which steps are peculiar to each subclass. Let's take for instance: foraging. By definition, it means searching actively for provisions or food - which involves some mode of movement and culminates in the consumption of the food found.

As a specific use case, let's examine fowl foraging.

```python
def forage(fowl: Fowl):
    fowl.hi()
    while not fowl.food:
        fowl.move()
    fowl.eat()
```

This would be our "template" - it outlines the steps needed to forage. Essentially, our fowl will continue to look for food until it finds one then consume it. From this, we can then see that our `Fowl` class need to have the `hi`, `move` and `eat` methods to satisfy the `forage` algorithm.

```python
class Fowl(object):
    def __init__(self):
        self.food = False;
        self.moves = 0

    def hi(self):
        print(f'Hi! I\'m a {self.__class__.__name__}')

    def move(self):
        from random import randint
        food = randint(0,2) % 2
        self.moves += 1
        self.food = food

    def eat(self):
        print(f'At last! I found food after {self.moves} steps')

    def lay(self):
        from random import randint
        print(f'I successfully laid {randint(5, 15)} eggs')

    def forage(self):
        self.hi()
        while not self.food:
            self.move()
        self.eat()
```

Our `hi` method introduces us to the fowl doing the foraging. The `move` method randomly determines if there is any food found as well as keeps track of the number of steps done by our fowl. Lastly, `eat` simply tells us we are consuming our food after n steps.

```python
class Chicken(Fowl):
    pass
```

Our subclass `Chicken` inherits all the methods available from `Fowl` without any customization. If we pass it to our `forage()` function, it would perform without any hiccups.

```python
chicken = Chicken()
chicken.forage()
```

And an expected result:

```
Hi! I'm a Chicken
At last! I found food after 11 steps
```

But the power of the template method is in its abilty to be customized with new logic without having to rewrite our "template", the forage function. Suppose we have a `Duck` which forages exactly like a chicken would but is far more noisy. It would quack everytime it makes a move.

We will be defining a new method `quack()` which will be called everytime the move method of the `Duck` class is called. But for this to take effect, we first have to override the base `move` method of our `Fowl` class. We can do so by defining a new `move` method inside our `Duck` implementation.

```python
class Duck(Fowl):
    def quack(self):
        print('I say quack quack quack because I\'m a Duck!')

    def move(self):
        self.quack()
        super().move()
```

And again, passing this to our `forage()` function:

```python
duck = Duck()
duck.forage()
```

We get something like:

```
Hi! I'm a Duck
I say quack quack quack because I'm a Duck!
I say quack quack quack because I'm a Duck!
I say quack quack quack because I'm a Duck!
I say quack quack quack because I'm a Duck!
I say quack quack quack because I'm a Duck!
I say quack quack quack because I'm a Duck!
I say quack quack quack because I'm a Duck!
I say quack quack quack because I'm a Duck!
At last! I found food after 8 steps
```

Notice that the content of our `Duck` class only shows the implementation details peculiar for that very specific use case. we did nothing to amend our existing `forage()` function, in fact, `Duck()` became a dropin replacement for our `Chicken()`.

Take note though of the subtle difference between the Strategy pattern and the Template Method pattern. They are alike in a lot of ways differing only in granularity. Template method uses inheritance to vary part of an algorithm, in this case, movement, while Strategy uses delegation to vary the entire algorithm.
