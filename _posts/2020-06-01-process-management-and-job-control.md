---
title: Process Management and Job Control
date: 2020-06-01 13:14:39 +0800
modified: 2020-06-01 13:14:39 +0800
tags: [cli, linux, sh]
description: 
series: Shell Scripting
usemathjax: true
---

A running instance of a program is called a process. A program that is stored in the disk, for example our `hello.sh` file, is not a process. If it is executed however, we can say that a process for the program was created and is running.

We can check the running processes using the `ps` command. 

> Note, `ps` is usually bundled up with your OS but if not, you may need to install it through the `procps` package from using your package manager. For example: `apt-get install procps` for debian based systems.

```sh
$ ps -ef | head -6
```

```sh
UID          PID    PPID  C STIME TTY          TIME CMD
root           1       0  0 18:21 ?        00:00:01 /sbin/init
root           2       0  0 18:21 ?        00:00:00 [kthreadd]
root           3       2  0 18:21 ?        00:00:00 [rcu_gp]
root           4       2  0 18:21 ?        00:00:00 [rcu_par_gp]
root           6       2  0 18:21 ?        00:00:00 [kworker/0:0H-kblockd]
```

Every process in the OS has a numerical identifier called a process ID (PID). The first process with PID=1 is usually the init process. In my case, this is `systemd`.

```bash
$ ll /sbin/init

lrwxrwxrwx 1 root root 22 Apr 24 17:37 /sbin/init -> ../lib/systemd/systemd
```

To list the process associated with our current Bash shell terminal, we can enter the following command:

```sh
$ ps

PID TTY          TIME CMD
 79 pts/0    00:00:00 bash
479 pts/0    00:00:00 ps
```

This provides us with the PID, TTY, TIME and CMD information. PID, as discussed above is the process ID. TTY is the terminal that executed the command. TIME is not the time the command was executed but rather the CPU utilization of a process which is incremented each time the system clock ticks and the process is found running. Finally, CMD is the command being run.

To list processes along with the parent process ID associated with the current terminal, we can pass in `-f` argument.

```sh
$ ps -f

UID          PID    PPID  C STIME TTY          TIME CMD
develop+      79      66  0 13:51 pts/0    00:00:00 /bin/bash
develop+     480      79  0 14:25 pts/0    00:00:00 ps -f
```

Notice that there are additional columns added to the result. Namely, UID, PPID, C and STIME. UID (or EUID) is the effective user id that triggered the process. C stands for the processor utilization. PPID is the parent process ID, the process that started it. STIME stands for start time.
