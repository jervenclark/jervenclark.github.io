---
title: Docker Resrouce Limits
date: 2020-06-04 13:23:39 +0800
modified: 2020-06-04 13:23:39 +0800
tags: [docker, docker-compose]
description:
series:
---

Docker changed its syntax for limiting resources. What used to be straightforward `mem_limit` in version 2 won't work out of the box for version 3. For starters, instead of the old `mem_limt: 100M` key, we have to declare a resource limit heirarchy like so:

```yaml
version: "3"

services:

  web_server:
    image: nginx:latest
    deploy:
      resources:
        limits:
          cpus: '0.001'
          memory: 100M
        reservations:
          cpus: '0.0001'
          memory: 200M
```

And for the running it, we have to pass in a `--compatibility` flag so it knows how to translate our definition into non-swarm counterpart.

```sh
$ docker-compose --compatibility up -d
```

And finally, running `docker stats` will give us:

```sh
CONTAINER ID  NAME            CPU %  MEM USAGE / LIMIT  MEM %   ...  PIDS
edb276dd1f9a  app_web_server  0.00%  / 200MiB           25.00%  ...  7
```
