---
layout: default
title: "Monitoring Docker with Prometheus and Grafana"
categories: [programming, monitoring, prometheus, grafana, docker]
---


# Monitoring Docker with Prometheus and Grafana

___


- [Exposing Docker metrics](#exposing-docker-metrics)
- [Configuring Prometheus](#configuring-prometheus)
- [Querying Prometheus](#querying-prometheus)
- [Configuring Grafana](#configuring-grafana)


___

## Exposing Docker metrics


Configuring [Docker](https://www.docker.com) as a Prometheus [^1] target is very straight forward. We can easily achieve this by enabling the `experimental` flag and exposing a `metric-address`[^2].

Append the following keys to `/etc/docker/daemon.json`. If it doesn't exist, create it. This tells Docker to expose its metrics on port 9323.


*/etc/docker/daemon.json:*
```json
{
  "metrics-addr" : "127.0.0.1:9323",
  "experimental" : true
}
```

After doing so, restart the  daemon:
```sh
systemctl restart docker.service
```


As of the time of writing, Docker can only monitor and expose metrics of itself. It cannot monitor running applications yet.

___

## Configuring Prometheus


To have Prometheus scrape Docker, we must first get a copy of prometheus and since we are using Docker anyway, let's run one in a container.

Let's first create a docker compose file with the following content:


*docker-compose.yml*
```yml
version: '3.4'
services:
  scraper:
    image: prom/prometheus
    container_name: prometheus
    restart: always
    ports:
      - 9090:9090
    volumes:
      - ./prometheus/:/etc/prometheus/
```


We also need to create a Prometheus config telling it to scrape Docker metrics. For more configuration options, you can refer to their [documentation](https://prometheus.io/docs/prometheus/latest/configuration/configuration/).

*prometheus/prometheus.yml*
```yml
global:
  scrape_interval:     15s
  evaluation_interval: 15s
  external_labels:
      monitor: 'codelab-monitor'

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']

  - job_name: 'docker'
    static_configs:
      - targets: ['localhost:9323']
```

This will launch a Prometheus service on port 9090.


___

## Querying Prometheus

Verify that you Prometheus can scrape the exposed metrics by navigating to `http://localhost:9090/targets`.

![alt text](/assets/img/prometheus-targets.png "Logo Title Text 1")

___

## Configuring Grafana

___

## Notes:
[^1]: [Prometheus](https://prometheus.io/) is an open-source monitoring and alerting toolit.
[^2]: Warning: The available metrics and the names of those metrics are in active development and may change at any time.
