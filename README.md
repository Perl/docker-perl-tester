# docker-perl-tester

This repo contains a script which builds Docker images with various
pre-installed bits:

* the `aspell` and `aspell-en` packages
* `cpanminus`
* `App::cpm`
* `Devel::Cover`
* various testing modules (see `cpanfile` in this repo)

# List of Perl modules

## Available on all Perl Versions

* Code::TidyAll::Plugin::SortLines::Naturally
* Code::TidyAll::Plugin::UniqueLines
* Devel::Cover
* Devel::Cover::Report::Codecov
* Devel::Cover::Report::Coveralls
* File::Temp
* List::MoreUtils
* Module::Build
* Pod::Coverage::TrustPod
* Test2::Bundle::Extended
* Test2::Plugin::NoWarnings
* Test2::Suite
* Test2::Tools::Explain
* Test::Builder
* Test::CPAN::Meta
* Test::Deep
* Test::Differences
* Test::EOL
* Test::Fatal
* Test::MinimumVersion
* Test::MockModule
* Test::Mojibake
* Test::More
* Test::Needs
* Test::Pod
* Test::Pod::Coverage
* Test::Portability::Files
* Test::RequiresInternet
* Test::Spelling
* Test::Synopsis
* Test::Version
* Test::Warnings

## Only on Perl 5.10 and later

* Code::TidyAll::Plugin::Test::Vars
* Pod::Readme
* Test::Vars

# Using Docker Images for your projects

The following tags are available

```
perldocker/perl-tester:v5.30
perldocker/perl-tester:v5.28
perldocker/perl-tester:v5.26
perldocker/perl-tester:v5.24
perldocker/perl-tester:v5.22
perldocker/perl-tester:v5.20
perldocker/perl-tester:v5.18
perldocker/perl-tester:v5.16
perldocker/perl-tester:v5.14
perldocker/perl-tester:v5.12
perldocker/perl-tester:v5.10
perldocker/perl-tester:v5.8
```

# Continuous Integrations

## Using the images with GitHub Workflow

Here is a sample workflow for Linux running on all Perl version 5.8 to 5.30
You can save the content in `.github/workflow/linux.yml`.

Note: this example is using cpm to install the dependencies from a cpanfile.
You can comment this line or use Dist::Zilla instead for supported Perl versions.

```
name: linux

on:
  push:
    branches:
      - '*'
    tags-ignore:
      - '*'
  pull_request:

jobs:
  perl:
    env:
      # some plugins still needs this to run their tests...
      PERL_USE_UNSAFE_INC: 0
      AUTHOR_TESTING: 1
      AUTOMATED_TESTING: 1
      RELEASE_TESTING: 1

    runs-on: ubuntu-latest

    strategy:
      fail-fast: false
      matrix:
        perl-version:
          - 'latest'
          - '5.28'
          - '5.26'
          - '5.24'
          - '5.22'
          - '5.20'
          - '5.18'
          - '5.16'
          - '5.14'
          - '5.12'
          - '5.10'
          - '5.8'

    container:
      image: perldocker/perl-tester:v${{ matrix.perl-version }}

    steps:
      - uses: actions/checkout@v1
      - name: perl -V
        run: perl -V
      - name: Install Dependencies
        run: cpm install -g --no-test --show-build-log-on-failure --cpanfile cpanfile
      - name: Makefile.PL
        run: perl Makefile.PL
      - name: make test
        run: make test
```

...

## Building Docker images

When pushing to GitHub, it's using a GitHub action `.github/workflows/publish-to-docker.yml`
to automagically build and publish the docker images for you.

If you consider cloning this repository, you wouldhave to set in your GitHub repository the following secret variables, with some example values.

```
DOCKER_REPO=perldocker/perl-tester
DOCKER_USERNAME=username
DOCKER_GITHUB_TOKEN=a-token-or-password
```

The images can be found at [https://hub.docker.com/repository/docker/perldocker/perl-tester/](https://hub.docker.com/repository/docker/perldocker/perl-tester/)

# Author

Oalef initiated the project.