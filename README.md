# docker-hub-prometheus-exported

![GitHub top language](https://img.shields.io/github/languages/top/predatorray/docker-hub-prometheus-exporter)
[![GitHub](https://img.shields.io/github/license/predatorray/docker-hub-prometheus-exporter)](./LICENSE)
[![Docker Build](https://img.shields.io/docker/cloud/build/zetaplusae/docker-hub-prometheus-exporter.svg)](https://hub.docker.com/repository/docker/zetaplusae/docker-hub-prometheus-exporter)
[![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/zetaplusae/docker-hub-prometheus-exporter)](https://hub.docker.com/repository/docker/zetaplusae/docker-hub-prometheus-exporter)

A docker image that exposes metrics about your Docker Hub repository in Prometheus format.


## Metrics

Metric Name | Help
--- | ---
`docker_hub_pulls` | docker repo pulls
`docker_hub_stars` | docker repo stars

## Example

```sh
# e.g. library/ubuntu
docker run -d \
    -p 80:80 \
    -e DOCKER_HUB_REPO='library/ubuntu' \
    zetaplusae/docker-hub-prometheus-exporter
```

By running the command above, an HTTP server will be started on port `80`.

`curl http://localhost/metrics` will output,

```sh
# HELP docker_hub_pulls Docker Hub pull count.
# TYPE docker_hub_pulls gauge
docker_hub_pulls{repo="library/ubuntu",} 2147483647

# HELP docker_hub_stars Docker Hub star count.
# TYPE docker_hub_stars gauge
docker_hub_stars{repo="library/ubuntu",} 11303

# HELP docker_hub_api_request_duration_seconds Docker Hub API Request Duration (sec).
# TYPE docker_hub_api_request_duration_seconds gauge
docker_hub_api_request_duration_seconds{path="/repositories/library/ubuntu/",repo="library/ubuntu",} 7
```

## Configuration

This image relies on the following environment variables:


Env Name                   | Required | Help
-------------------------- | -------- | ---
`DOCKER_HUB_REPO`          | true     | The name of your Docker Repository.<br>(e.g. `zetaplusae/docker-hub-prometheus-exporter`)
`DOCKER_HUB_V2_API_SERVER` | false    | The URL to the Docker Hub V2 API Server.<br>(Default: `https://hub.docker.com/v2`)

## Links

This project is developed with the help of these two open-sourced project:

 - [prometheus-bash-exposition](https://github.com/predatorray/prometheus-bash-exposition): a command line tool, written in Bash, that prints Prometheus exposition format file.

 - [lighttpd-cgi-docker](https://github.com/predatorray/lighttpd-cgi-docker): an out-of-the-box lighttpd image for CGI scripts based HTTP server.

If you would like to collect metrics about your Github repository, please visit this project:

 - [github-prometheus-exporter](https://github.com/predatorray/github-prometheus-exporter)

## Support

You can ask me anything about this project by [creating an issue](https://github.com/predatorray/docker-hub-prometheus-exporter/issues).
