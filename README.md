# docker-perl-tester

This repo is used to build Perl Docker images with various pre-installed bits:

- the `aspell` and `aspell-en` packages
- `cpanminus`
- `App::cpm`
- `Devel::Cover`
- various testing modules
- Dist::Zilla with some common plugins (for Perl >= 5.14)

At this points images are refreshed daily, which could change overtime if it becomes an issue.
This should guarantee you to test uptodate CPAN stack.

Note: if one dependency fails to install, this should not impact you as the image would not be published
on failures.

# List of Perl modules

## Available on all Perl Versions

- Code::TidyAll::Plugin::SortLines::Naturally
- Code::TidyAll::Plugin::UniqueLines
- Devel::Cover
- Devel::Cover::Report::Codecov
- Devel::Cover::Report::Coveralls
- ExtUtils::MakeMaker
- File::Temp
- List::MoreUtils
- Module::Build
- Pod::Coverage::TrustPod
- Test2::Bundle::Extended
- Test2::Plugin::NoWarnings
- Test2::Suite
- Test2::Tools::Explain
- Test::Builder
- Test::CPAN::Meta
- Test::Deep
- Test::Differences
- Test::EOL
- Test::Fatal
- Test::MinimumVersion
- Test::MockModule
- Test::Mojibake
- Test::More
- Test::Needs
- Test::Notabs
- Test::Pod
- Test::Pod::Coverage
- Test::Portability::Files
- Test::RequiresInternet
- Test::Simple
- Test::Spelling
- Test::Synopsis
- Test::Version
- Test::Warnings

## Only on Perl 5.10 and later

- Code::TidyAll::Plugin::Test::Vars
- Pod::Readme
- Test::Vars

## Only on Perl 5.14 and later

- Dist::Zilla & friends
- Dist::Zilla::PluginBundle::Author::ETHER

# Using Docker Images for your projects

The images can be found at [https://hub.docker.com/repository/docker/perldocker/perl-tester/](https://hub.docker.com/repository/docker/perldocker/perl-tester/)

The following tags are available from the repository `perldocker/perl-tester`

```
5.32
5.30
5.28
5.26
5.24
5.22
5.20
5.18
5.16
5.14
5.12
5.10
5.8
```

# Continuous Integrations

## Using the images with GitHub Workflow

Here is a sample workflow for Linux running on all Perl version 5.8 to 5.32
You can save the content in `.github/workflow/linux.yml`.

Note: this example is using cpm to install the dependencies from a cpanfile.
You can comment this line or use Dist::Zilla instead for supported Perl versions.

```yaml
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
          - '5.32'
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
      image: perldocker/perl-tester:${{ matrix.perl-version }}

    steps:
      - uses: actions/checkout@v2
      - name: perl -V
        run: perl -V
      - name: Install Dependencies
        run: cpm install -g --no-test --show-build-log-on-failure --cpanfile cpanfile
      - name: Makefile.PL
        run: perl Makefile.PL
      - name: make test
        run: make test
```

You can find more details on how to setup GitHub workflow to smoke Perl projects by reading [skaji/perl-github-actions-sample](https://github.com/skaji/perl-github-actions-sample) GitHub repository.

## Using GitHub actions

You can also consider using GitHub actions:
- [perl-actions/install-with-cpanm](https://github.com/perl-actions/install-with-cpanm)
- [perl-actions/install-with-cpm](https://github.com/perl-actions/install-with-cpm)

## Building Docker images

When pushing to GitHub, it's using a GitHub action `.github/workflows/publish-to-docker.yml`
to automagically build and publish the docker images for you.

If you consider cloning this repository, you would have to set in your GitHub repository the following secret variables, with some example values.

```
DOCKER_REPO=perldocker/perl-tester
DOCKER_USERNAME=username
DOCKER_GITHUB_TOKEN=a-token-or-password
```

# Author

@oalders initiated the project and @atoomic tried to give it more public visibility
volunteers/ideas are welcome to improve the project.
