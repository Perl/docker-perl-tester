# tester-perl

This repo contains a script which builds Docker images with various
pre-installed bits:

* the `aspell` and `aspell-en` packages
* `cpanminus`
* `App::cpm`
* `Devel::Cover`
* various testing modules (see `cpanfile` in this repo)


## Building Docker images

When pushing to GitHub, it's using a GitHub action `.github/workflows/publish-to-docker.yml`
to automagically build and publish the docker images for you.

You would have to set in your GitHub repository the following secret variables, with some example values.

```
DOCKER_REPO=oalders/tester-perl
DOCKER_USERNAME=oalders
DOCKER_GITHUB_TOKEN=a-token-or-password
```

I'm open to adding more testing modules and dependencies if other people find this to be helpful.

The images can be found at [https://hub.docker.com/repository/docker/oalders/tester-perl/](https://hub.docker.com/repository/docker/oalders/tester-perl/)
