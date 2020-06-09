---
title: Shell Functions
date: 2020-06-09 21:08:34 +0800
modified: 2020-06-09 21:08:34 +0800
tags: [cli, linux, sh]
description: Introduction to shell functons
series: Shell Scripting
---

In the previous posts we learned about the basic shell constructs. Now, it's time to put them into practice. Shell functions are a means to group together those building blocks of code to create more sophisticated commands. 

## Aliases

Before we dive into functions, let's discuss a very closely related command - the alias. We can define out own aliases to get similar option-defining shortcuts. Like for example, a personal favorite of mine:

```sh
alias ll='ls -l'
```

From here on, the `ll` command can be used an will expand to run the full `ls -l` upon execution.

```sh
$ ll
total 100K
... # truncated output
-rw-r--r--  1 jervenclark jervenclark  262 May 30 11:15 browserconfig.xml
-rw-r--r--  1 jervenclark jervenclark 1.7K May 31 23:06 _config.yml
drwxr-xr-x  3 jervenclark jervenclark 4.0K May 31 23:06 _data
-rw-r--r--  1 jervenclark jervenclark  539 Jun  6 09:25 docker-compose.yml
drwxr-xr-x  2 jervenclark jervenclark 4.0K Jun  1 22:33 _drafts
-rw-r--r--  1 jervenclark jervenclark  265 May 30 20:20 Gemfile
-rw-r--r--  1 jervenclark jervenclark 1.9K May 30 20:23 Gemfile.lock
drwxr-xr-x  2 jervenclark jervenclark 4.0K May 31 14:17 _includes
... # truncated output
```

We can add further options to our call as if we're using the `ls -l` command like so:
```
$ ll *.md
-rw-r--r-- 1 jervenclark jervenclark  65 May 30 11:15 404.md
-rw-r--r-- 1 jervenclark jervenclark 623 May 30 11:15 about.md
-rw-r--r-- 1 jervenclark jervenclark 447 Jun  1 12:21 archive.md
-rw-r--r-- 1 jervenclark jervenclark  20 May 30 11:15 index.md
-rw-r--r-- 1 jervenclark jervenclark  79 May 30 11:15 notes.md
-rw-r--r-- 1 jervenclark jervenclark  21 May 30 11:15 README.md
-rw-r--r-- 1 jervenclark jervenclark 631 May 31 12:33 series.md
-rw-r--r-- 1 jervenclark jervenclark 494 Jun  1 12:22 tags.md
-rw-r--r-- 1 jervenclark jervenclark  89 May 30 11:15 thanks.md
```

Aliases are very handy and are simple to understand, but it is important to note that they have a very serious shortcoming. There is no way we can modify their behaviour based on any arguments given to them. They are essentially just simple text substitutions.

For example, suppose we want to make an aliass, `mkcd`, that created a directory before changing into it. If you wanted to do this with aliases you might try defining something like this, separating each command with a semicolon:

```sh
alias mkcd='mkdir -p; cd'
```
Unfortunately for us, it doesn't work when we run it

```sh
$ mkcd new-directory
mkdir: missing operand
Try 'mkdir --help' for more information.
cd: no such file or directory: new-directory
```

The `new-directory` argument was only passed to the last command, `cd`. What the shell understood was execute the command `mkdir -p` and `cd new-directory` after it. That's why it was giving us the error that it cannot find an operand because nothing was passed! We need a way to pass the same argument to both commands.

Another problem with aliasess is that invoking them in bash scripts doesn't work. They are strictly for use in interactive mode. Worse, there is no error raiseed when they're defined. They just don't work when called. To make matters worse, in some shells, they do work. It's better to avoid the whole mess by aalways using functions instead.

## Functions

Functions are a much better waay of defiining our own commands for use in both the command line and in scripts. They can do everything aliases can and more.

For example, we can rewrite our `mkcd` alias like so:

```sh
mkcd() {
    mkdir -p $1
    cd $1
}
```

Now, we can run `mkcd new-directory` like what we always wanted.

The previous definition was very simple but it is made up of a few parts.
 - a function name, followed by a pair of parentheses `mkcd()`. The name must start with a letter and the rest of the name must be only letters, numbers or underscores. Bash allows space in between the name and the parentheses so `mkcd()` and `mkcd ()` are both acceptable. My personal preference is no space in between.
 - an opening and closing curly bracket to denote that this is the scope of the commands that belong to this function
 - lastly, at least one command, each one followed by a control operator. In this case it is a new line but semicolons work too especially if they are all in  single line like this `mkcd() { mkdir -p $1; cd $1 }` else it will be treated as one long command and you'll get a syntax error.

## Returning Values

Like filesystem scripts or programs, shell functions can have exit values. These are integer values normally used to described how well the function did its job, often for use by the calling shell to decide what to do next after the function completes. In the case of functions, we will call these return values for clarity, as they use the return keyword rather than exit.

For example:

```sh
succeed() { return 0; }
fail() { return 1; }
```

A function does not have to have a return statement. If you leave it out, or use return without specifying a number, the functions return value will be the exit value of the last command it ran. This means, we could write these functions like this instead:

```sh
succeed() { true; }
fail() { false; }
```

Be careful though not to confuse return and exit. The former is for functions, the latter is for scriipts. If you use exit in function, the shell itself will exit not just the function.

An especially good way of using return is by short-circuiting your functions as a way to stop processing due to usage errors. In our `mkcd` example, we know we can't accept more than one argument because we cant change into more than one directory, we could add a few lines to the functiion for a full definition, like so:

```sh
mkcd() {
    if ($# != 1); then
        return 1
    fi
    mkdir -- "$1" && cd -- "$1"
}
```

## Function I/O

Keep in mind that we cannot return strings or arrays from a functiion. The return keyword is not the same as used in other sstructured programming languages like PHP or Python. It is strictly for integers and is intended to only describe a functions success or failure.

There are, however, legitemate instances where we really need the values calculated by a function. One way to circumvent this limitation is by printing the output.

```
home() {
    printf '%s' "$HOME";
}
```

Running it would yield:

```sh
$ home
/home/jervenclark
```

You can treat function calls that emit output on the command line or in scripts the samee waay you can any other command that emits output. For example, we could count the number of characters in our `home` output with `wc` like so:

```sh
$ home | wc -c
17
```

Similarly, functions can read data from stdin as well.

## Function Scope

Functions defined during a session are only available in that session. You cannot define a function on the command line, and then expect to have it available in a script you execute later or in another user's session. If you really want to, you would need to include the function definition in the script and have the other users load your function first.
