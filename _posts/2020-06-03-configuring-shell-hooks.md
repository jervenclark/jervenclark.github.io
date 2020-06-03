---
title: Configuring Shell Hooks
date: 2020-06-03 16:16:51 +0800
modified: 2020-06-03 16:16:51 +0800
tags: [linux, config, shell, bash, zsh]
description: Configuring shell hooks
series:
---

Working with multiple python projects, especially with very different library versions is a complete nightmare. That's why tools like `virtualenv`[^1] is a godsend. My only complain is that, constantly activating, reactivating and deactivating environment is very tiresome or at least for me because I'm extremely lazy. So, I decided to automate activation and deactivationn when switching directories.

## ZSH

Luckily for `zsh`, it comes with a few hook functions[^2] we can use to accomplish this. On my `.zshrc`, I added a check for the existence of the `venv` directory and activate it exists.

```sh
# Hook to execute whenever the current working directory is changed
chpwd() {
    activate_virtualenv
}

# Activate virtualenv on change directory
activate_virtualenv() {
    if [ -d $PWD/venv ]; then
        . $PWD/venv/bin/activate
    fi
}
```

Easy enough right? Deactivation, on the other hand, is a bit of a longer process. For this, we need to get the working directory for our `venv`. I'm gonna store it to the env variable `VIRTUAL_ENV_WORKDIR` right after we activate `venv`. Like so:

```sh
# truncated code
...

. $PWD/venv/bin/activate
VIRTUAL_ENV_WORKDIR=$PWD

...
# truncated code
```

Now that we have a reference, we can test if the target directory we are changing to is a directory outside of our `venv` working directory. If it is indeed outside, we are going to deactivate `venv` and unset our `VIRTUAL_ENV_WORKDIR` to things back to what they were before.

```sh
# Hook to execute whenever the current working directory is changed
chpwd() {
    activate_virtualenv
    deactivate_virtualenv
}

# truncated code
...

# Deactivate virtualenv on change directory
deactivate_virtualenv() {
    if [[ "$PWD" != "$VIRTUAL_ENV_WORKDIR"* ]]; then
        deactivate
        unset VIRTUAL_ENV_WORKDIR
    fi
}
```

It works but we can refactor our code further:

```sh
# Hook to execute whenever the current working directory is changed
chpwd() {
    configure_virtualenv
}

# Configure virtualenv on change directory
configure_virtualenv() {
    if [ -d $PWD/venv ]; then
        . $PWD/venv/bin/activate
        VIRTUAL_ENV_WORKDIR=$PWD
    elif [[ "$PWD" != "$VIRTUAL_ENV_WORKDIR"* ]] && [ "$VIRTUAL_ENV" ]; then
        deactivate
        unset VIRTUAL_ENV_WORKDIR
    fi
}
```

## Bash

The code above doesn't translate directly to bash tho. For it to work, we have to make a few minor adjustments. Instead of declaring a `chpwd`, we need to use `PROMPT_COMMAND`. This will be run just before bash displays a prompt.

```sh
PROMPT_COMMAND=configure_virtualenv
```

Putting everything together:

```sh
#!/bin/bash

# Hook to execute whenever the current working directory is changed
if [ ${ZSH_VERSION} ]; then
    # 'ZSH_VERSION' only defined in Zsh
    chpwd() {
        configure_virtualenv;
    }
elif [ ${BASH_VERSION} ]; then
    # 'BASH_VERSION' only defined in Bash
    PROMPT_COMMAND=configure_virtualenv
fi

# Configure virtualenv on change directory
configure_virtualenv() {
    if [ -d $PWD/venv ]; then
        . $PWD/venv/bin/activate
        VIRTUAL_ENV_WORKDIR=$PWD
    elif [[ "$PWD" != "$VIRTUAL_ENV_WORKDIR"* ]] && [ "$VIRTUAL_ENV" ]; then
        deactivate
        unset VIRTUAL_ENV_WORKDIR
    fi
}
```

## Notes
[^1]: [virtualenv](https://pypi.org/project/virtualenv/) is a tool for managing multiple python environments.
[^2]: zsh [hook functions](http://zsh.sourceforge.net/Doc/Release/Functions.html#Hook-Functions)
