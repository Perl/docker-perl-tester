# docker-perl-tester

This repo is used to build Perl Docker images with various pre-installed bits:

* the `aspell` and `aspell-en` packages
* `cpanminus`
* `App::cpm`
* `Devel::Cover`
* various testing modules
* Dist::Zilla with some common plugins (for Perl >= 5.14)

# List of Perl modules

## Available on all Perl Versions

* Code::TidyAll::Plugin::SortLines::Naturally
* Code::TidyAll::Plugin::UniqueLines
* Devel::Cover
* Devel::Cover::Report::Codecov
* Devel::Cover::Report::Coveralls
* ExtUtils::MakeMaker
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
* Test::Notabs
* Test::Pod
* Test::Pod::Coverage
* Test::Portability::Files
* Test::RequiresInternet
* Test::Simple
* Test::Spelling
* Test::Synopsis
* Test::Version
* Test::Warnings

## Only on Perl 5.10 and later

* Code::TidyAll::Plugin::Test::Vars
* Pod::Readme
* Test::Vars

## Only on Perl 5.14 and later

* Dist::Zilla & friends
* Dist::Zilla::PluginBundle::Author::ETHER

# Using Docker Images for your projects

The images can be found at [https://hub.docker.com/repository/docker/perldocker/perl-tester/](https://hub.docker.com/repository/docker/perldocker/perl-tester/)

The following tags are available from the repository `perldocker/perl-tester`

```
v5.30
v5.28
v5.26
v5.24
v5.22
v5.20
v5.18
v5.16
v5.14
v5.12
v5.10
v5.8
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
          - '5.30'
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

# Author

Oalders initiated the project and atoomic tried to give it more public visibility.