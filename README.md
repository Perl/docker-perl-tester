# tester-perl

This repo contains a script which builds Docker images with various
pre-installed bits:

* the `aspell` and `aspell-en` packages
* `cpanminus`
* `App::cpm`
* `Devel::Cover`
* various testing modules (see `cpanfile` in this repo)


To build and push:
```bash
./bin/build-and-push.sh
```

I'm open to adding more testing modules and dependencies if other people find this to be helpful.

The images can be found at [https://hub.docker.com/repository/docker/oalders/tester-perl/](https://hub.docker.com/repository/docker/oalders/tester-perl/)
