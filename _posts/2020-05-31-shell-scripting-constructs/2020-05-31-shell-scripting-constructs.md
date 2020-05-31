---
title: Shell Scripting Constructs
date: 2020-05-31 08:53:45 +0800
modified: 2020-05-31 08:53:45 +0800
tags: [linux, cli, sh]
description:
series: Shell Scripting
---

## Variables

In programming, an essential feature to use a name or a label to refer to some other quantity such as a value or command is commonly referred to as a variable. And like in other languages, we can also use them inside our shell scripts. We can assign them using the following syntax: `variable=value`. Do not introduce any space on either side of the equal sign, =. Moreover, variable names must only begin with a letter or an underscore.

```
greeting='Hello, World'
```

We can retrieve the value of a variable by placing a dollar sign, $, in front of the variable name like so `$variable`.

```
echo $greeting
```

## Expressions

The `expr` command is used to evaluate a specified expression using the syntax: `expr arg1 operator arg2 ...`. Here, `arg1` and `arg2` represents the arguments that will be evaluated by the expressions combined by the operator.

```
x=10
y=20
expr $x + $y
```

The previous code will add the values of variables x and y which will in turn yield the result 30. We can also store the results of an expression in a variable.

```
z=`expr $x + $y`
```

The `let` command is used for assigning values to the variables as well as for evaluating the expression. It is the same as the `expr` command but it doesn't require the dollar sign, $, with the variables. So, the previous command is equivalent to:

```
let z=x+y
```

There is also an alternative syntax to assigning values without `let` by using double opening and closing parentheses, (( and )).

```
x=10
y=20
z=30
((z=x+y+z+z))
```

The previous code will reassign z with the evaluated value for `x+y+z`.

## Parameters

Shell scripts can read up to nine command-line parameters or arguments into a special variable. These parameters appear as a special shell script variables named `$1`, `$2`, though `$9`. The first variable, `$0` is the name of the script.

Consider the following script `arguments.sh` with the following content:

```
#!/bin/bash

echo "Total number of parameters: $#"
echo "The parameters are: $*"
echo "Script name: $0"
```

If we run it like so:

```
$ ./arguments.sh
```

It will print the output:

```
Total number of parameters: 0
The parameters are:
Script name: ./arguments.sh
```

Let's try passing some arguments:

```
$ ./arguments.sh apple orange melon coconut
```

This will output:

```
Total number of parameters: 4
The parameters are: apple orange melon coconut
Script name: ./arguments.sh
```

In this case, apple will be stored in `$1`, orange will be stored in `$2`, and so on. Additionally, all these values will be stored collectively inside `$*` and the number of arguments is stored in `$#`. The extra unassigned variables have null values. 

To illustrate further, let's edit the script:

```
echo "Total number of parameters: $#"
echo "The parameters are: $*"
echo "Script name: $0"
echo "\$1: $1"
echo "\$2: $2"
echo "\$3: $3"
echo "\$4: $4"
echo "\$5: $5"
echo "\$6: $6"
echo "\$7: $7"
echo "\$8: $8"
echo "\$9: $9"
```

If we run the same command:

```
$ ./arguments.sh apple orange melon coconut
```

it will give us:

```
Total number of parameters: 4
The parameters are: apple orange melon coconut
Script name: ./arguments.sh
$1: apple
$2: orange
$3: melon
$4: coconut
$5:
$6:
$7:
$8:
$9:
```

## User Input

Reading user input is very easy using the `read` command with the following syntax: `read variable`. It looks very much like let but the only difference is that it will generate a prompt for the user to enter values.

Let's try it out with the following script:

```
#!/bin/bash

read first_name
read last_name
echo "Hello, $first_name $last_name"
```

It will first prompt the user with the line:

```
Please enter your first name: 
```

and will wait until the enter key is pressed. It will then prompt:

```
Please enter your last name: 
```

And finally, it will concatenate the values for `$first_name` and `$last_name` to output 

```
Hello, Jerven Chua
```

## for Loop

Loops are control structures used for executing a set of comamnds repeatedly. A `for` loop is a specific kind of loop with the following syntax.

```
for variable
    in list_of_values
do
    command1
    command2
    ...
done
```

The `variable`will be assigned a value from the `list_of_values` for every iteration and the commands between `do` and `done` will be executed on that `variable`. This is repeated for each value in the `list_of_values`.

Suppose we have the script:

```
#!/bin/bash

for fruit
    in $*
do
    echo 'The name of the fruit is $fruit'
    uppercase=`sed -E 's/(\w+)/\U\1/'`
    echo 'The equivalent uppercase name is $uppercase'
done
```

If we pass in the parameters:

```
$ ./fruit.sh mango banana jackfruit ube
```

It will output:

```
The name of the fruit is mango
The uppercase name is MANGO

The name of the fruit is banana
The uppercase name is BANANA

The name of the fruit is jackfruit
The uppercase name is JACKFRUIT

The name of the fruit is ube
The uppercase name is UBE

```

As we can see, it iterated over all the arguments we passed to the script and converted them to uppercase sequentially.

## while Loop

Another kind of loop is the `while` loop. It is different from the `for` loop because it only terminates when a specific condition becomes false. It hass the following syntax:

```
while [logical expression]
do
    command1
    command2
    ...
done
```

Let's take for example the script:

```
#!/bin/bash

n=0

while [ $n -le 10 ]
do
    echo $n
    ((n++))
done
```

The previous script will print the numbers from 0 through 10. Here is a table for comparison operators we can use in a shell script:

**Integer comparison operators**

| Operator | Description              | Syntax        |
|:---------|:-------------------------|:--------------|
| -eq      | equal to                 | [ $a -eq $b ] |
| -ne      | not equal to             | [ $a -ne $b ] |
| -gt      | greater than             | [ $a -gt $b ] |
| -ge      | greater than or equal to | [ $a -ge $b ] |
| -lt      | less than                | [ $a -lt $b ] |
| -le      | less than or equal to    | [ $a -le $b ] |
| >        | greater than             | (($a > $b))   |
| >=       | greater than or equal to | (($a >= $b))  |
| <        | less than                | (($a < $b))   |
| <=       | less than or equal to    | (($a <= $b))  |

**String comparison operators**

| Operator | Description                              | Syntax                      |
|:---------|:-----------------------------------------|:----------------------------|
| =        | equal to                                 | [ $a = $b ]                 |
| ==       | equal to (synonym for =)                 | [ $a == $b ]                |
| !=       | not equal to                             | [ $a != $b]                 |
| <        | less than in ASCII alphabetical order    | [[ $a < $b]] or [ $a \< $b] |
| >        | greater than in ASCII alphabetical order | [[ $a > $b]] or [ $a \> $b] |
| -z       | string is null, that it has zero length  | [ -z "$a" ]                 |
| -n       | string is null                           | [ -n "$a" ]                 |

Keep in mind to always quote a string inside the test bracket when testing for null.

## until Loop

The until loop is very much like the `for` loop in the sense that it only terminates for a specific condition. In contrast to `for` loop, however, an `until` loop will keep on running the command until the specified logical expression becomes true.

```
until [logical expression]
do
    command1
    command2
    ...
done
```

An equivalent until `loop` for the `while` counter we have will be:

```
#!/bin/bash

n=0

until [ $n -gt 10 ]
do
    echo $n
    ((n++))
done
```

## if Statement

And `if` statement is another flow-control structure that directs the flow of a program depending on how the condition is evaulated.

```
if [logiical expression]
then
    command1
    command2
else
    command3
    command4
fi
```

The following script prints a message if the value of `$n` is greater than 10:

```
#!/bin/bash

echo -n "provide a number: "
read n
if [ $n -gt 10 ]
then
    echo 'Number is greater than 10'
fi
```

Run 1

```
provide a number: 10
```

Run 2

```
provide a number: 11
Number is greater than 10
```

The following script uses the optional else clause to print odd or even accordingly:

```
#!/bin/bash

echo -n "provide a number: "
read n
if [ $(($n % 2)) -eq 0 ]
then
    echo 'Number is greater even'
else
    echo 'Number is greater odd'
fi
```

Run 1

```
provide a number: 10
Number is greater even
```

Run 2
```
provide a number: 5
Number is greater odd
```
